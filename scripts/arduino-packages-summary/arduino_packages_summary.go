// Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
// SPDX-License-Identifier: BSD-3-Clause

package main

import (
	"encoding/json"
	"os"
	"strings"

	"github.com/arduino/go-paths-helper"
)

type Sbom struct {
	Artifacts []Artifact `json:"artifacts"`
}

type Artifact struct {
	Name    string `json:"name"`
	Version string `json:"version"`
}

func main() {
	var sboms Sbom
	f, err := paths.New("rootfs-sbom.syft.json").ReadFile()
	if err != nil {
		println(err.Error())
		os.Exit(1)
	}

	err = json.Unmarshal(f, &sboms)
	if err != nil {
		println(err.Error())
		os.Exit(1)
	}

	output := "- Included Arduino packages:\n"
	for _, a := range sboms.Artifacts {
		if strings.Contains(a.Name, "arduino-") || strings.Contains(a.Name, "adbd") {
			output += "	- " + a.Name + ": " + a.Version + "\n"
		}
	}

	outFile := paths.New("arduino-summary.md")
	outFile.WriteFile([]byte(output))
	if err != nil {
		println(err.Error())
		os.Exit(1)
	}
	os.Exit(0)
}
