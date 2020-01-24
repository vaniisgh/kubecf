package main

import (
	"log"

	"github.com/SUSE/kubecf/klog/cmd/klog"
)

func main() {
	klogCmd := klog.NewKlogDefaultCommand()
	if err := klogCmd.Execute(); err != nil {
		log.Fatal(err)
	}
}
