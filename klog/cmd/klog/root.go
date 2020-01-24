package klog

import (
	"github.com/spf13/cobra"

	"github.com/SUSE/kubecf/klog/pkg/kube"
)

func NewKlogDefaultCommand() *cobra.Command {
	return NewKlogCommand()
}

func NewKlogCommand() *cobra.Command {
	cmd := &cobra.Command{
		Use:           "klog",
		Short:         "klog is a tool for inspecting logs and events of a KubeCF installation",
		SilenceUsage:  true,
		SilenceErrors: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			kube.ListPods()
			return nil
		},
	}
	return cmd
}
