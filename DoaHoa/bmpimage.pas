{Only Compatible:BMP 24bit+BMP 32bit}

UNIT BmpImage;

{$mode objfpc}

INTERFACE
uses graph;

{$define DECLARATION}
  {$include hTColors}
  {$include hFbpSys}
  {$include hConvert}
  {$include hBmpPrx}
{$undef DECLARATION}

IMPLEMENTATION

uses wincrt, math, video, vidutil, sysutils, kgraphb;

{$define IMPLEMENTATION}
  {$include hTColors}
  {$include hFbpSys}
  {$include hConvert}
  {$include hBmpPrx}
{$undef IMPLEMENTATION}

INITIALIZATION

{$define INITIALIZATION}
  {$include hTColors}
  {$include hFbpSys}
  {$include hConvert}
  {$include hBmpPrx}
{$undef INITIALIZATION}

END.
