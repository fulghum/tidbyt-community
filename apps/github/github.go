// Package github provides details for the GitHub applet.
package github

import (
	_ "embed"

	"tidbyt.dev/community/apps/manifest"
)

//go:embed github.star
var source []byte

// New creates a new instance of the GitHub applet.
func New() manifest.Manifest {
	return manifest.Manifest{
		ID:          "github",
		Name:        "GitHub",
		Author:      "Fulghum",
		Summary:     "Display GitHub stats",
		Desc:        "Display various stats from GitHub, such as project stars, number of open issues, and more.",
		FileName:    "github.star",
		PackageName: "github",
		Source:  source,
	}
}
