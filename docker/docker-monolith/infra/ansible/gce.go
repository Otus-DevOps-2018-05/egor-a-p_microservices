#!/usr/bin/env gorun

package main

import (
	"fmt"
	"os/exec"
	"io/ioutil"
	"os"
	"encoding/json"
)

const (
	command      = "gcloud"
	computeArg   = "compute"
	instancesArg = "instances"
	listArg      = "list"
	formatArg    = "--format=json(name,tags.items,networkInterfaces[0].accessConfigs[0].natIP)"
)

type AccessConfig struct {
	NatIP string `json:"natIP"`
}

type NetworkInterface struct {
	AccessConfigs []AccessConfig `json:"accessConfigs"`
}

type Tags struct {
	Items []string `json:"items"`
}

type GoogleHost struct {
	Name              string             `json:"name"`
	NetworkInterfaces []NetworkInterface `json:"networkInterfaces"`
	Tags              Tags               `json:"tags"`
}

type Hosts struct {
	Hosts []string `json:"hosts"`
}

type AnsibleHost struct {
	AnsibleHost string `json:"ansible_host"`
}

type InventoryMeta struct {
	HostVars map[string]AnsibleHost `json:"hostvars"`
}

func convert(hosts []GoogleHost) (map[string]Hosts, InventoryMeta) {
	hostsMap := make(map[string]Hosts)
	meta := InventoryMeta{make(map[string]AnsibleHost)}

	for _, host := range hosts {
		for _, tag := range host.Tags.Items {
			hosts, ok := hostsMap[tag]
			if !ok {
				hosts = Hosts{make([]string, 0)}
			}
			hosts.Hosts = append(hosts.Hosts, host.Name)
			hostsMap[tag] = hosts
			meta.HostVars[host.Name] = AnsibleHost{host.NetworkInterfaces[0].AccessConfigs[0].NatIP}
		}
	}
	return hostsMap, meta
}

func main() {
	cmd := exec.Command(command, computeArg, instancesArg, listArg, formatArg)
	stdout, _ := cmd.StdoutPipe()
	stderr, _ := cmd.StderrPipe()

	cmd.Start()
	be, _ := ioutil.ReadAll(stderr)
	bo, _ := ioutil.ReadAll(stdout)
	cmd.Wait()

	if len(be) > 0 {
		fmt.Println(string(be))
		os.Exit(1)
	}

	var hosts []GoogleHost

	if err := json.Unmarshal(bo, &hosts); err != nil {
		panic(err)
	}

	hostsMap, meta := convert(hosts)

	result := make(map[string]interface{})

	for k, v := range hostsMap {
		result[k] = v
	}
	result["_meta"] = meta

	bytes, _ := json.Marshal(result)

	fmt.Println(string(bytes))
}
