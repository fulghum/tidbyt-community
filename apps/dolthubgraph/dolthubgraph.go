// Package dolthubgraph provides details for the DoltHub Graph applet.
package dolthubgraph

import (
	_ "embed"

	"tidbyt.dev/community/apps/manifest"
)

//go:embed dolthub_graph.star
var source []byte

// New creates a new instance of the DoltHub Graph applet.
func New() manifest.Manifest {
	return manifest.Manifest{
		ID:          "dolthub-graph",
		Name:        "DoltHub Graph",
		Author:      "fulghum",
		Summary:     "Graph a DoltHub query",
		Desc:        "Displays a customizable query from a DoltHub database.",
		FileName:    "dolthub_graph.star",
		PackageName: "dolthubgraph",
		Source:  source,
	}
}
