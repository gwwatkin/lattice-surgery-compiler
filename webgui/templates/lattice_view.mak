<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Lattice Surgery QEC</title>
  <style>
  html, body{
      height: 100%;
      padding: 0;
      margin: 0;
      white-space: nowrap;
      overflow: hidden;

  }
  #toolbar
  {
      /* Make it independent of zoom */
      height: 10%;
      line-height: 10vh;
      font-size: 5vh;
      /* Keep it above the lattice */
      z-index: 100;
      position: relative;
      /* style */
      background-color: lavender;
      border-bottom: solid darkgrey 1.5vh;
  }
  #draggable-container{
      font-size: 0;
      z-index: 10;
  }
  .slice{
      display: none;
  }
  .lattice-cell{
      border: 0.5px solid #a2abae;
      height: 50pt;
      width: 50pt;
      display: inline-block;
      position: relative;
      font-size:10px;
    }
  </style>
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#draggable-container" ).draggable();
  } );
  </script>
    <script>
        document.selected_slice = 0
        $(document).ready(function(){
            $('#slice-'+document.selected_slice).show();
            $('#slice-number').text(document.selected_slice);
        });
        function change_slice(offset)
        {
            $('#slice-'+document.selected_slice).hide();
            document.selected_slice = Math.min(Math.max(0,document.selected_slice+offset),${len(slices)-1});
            $('#slice-'+document.selected_slice).show();
            $('#slice-number').text(document.selected_slice);
        }
        $(document).ready(function(){
            $(document).keydown(function(event){
            if(event.which===78)
                change_slice(+1);
            else if(event.which===80)
                change_slice(-1);
            });
        });
    </script>
</head>
<body>

<div id="toolbar">
    &nbsp;&nbsp;
    <span style="border: solid 0.5vh gray;">
        &nbsp;Select Time Slice:
        &nbsp;
        <a href="javascript:change_slice(-1)">Prev</a>
        &nbsp;<span id="slice-number"></span>&nbsp;
        <a href="javascript:change_slice(+1)">Next</a>
        &nbsp;
    </span>
</div>
<div id="draggable-container">
    %for slice_number, array in enumerate(slices):
        <div id="slice-${slice_number}" class="slice">
            %for row_idx, row in enumerate(array):
                <div class="lattice-row">
                    %for col_idx, cell in enumerate(row):
                       <div class="lattice-cell">
                           <div class="lattice-cell-inside"
                            style="
                                    height: 42pt;
                                    width: 42pt;
                                    vertical-align: middle;
                                    display: inline-block;
                                    border-width: 4pt;
                                    border-style: solid;
                                    %if cell is not None and cell.patch_type==patches.PatchType.Ancilla:
                                        border-color: white;
                                    %else:
                                        border-color: transparent;
                                    %endif
                                    text-align: center;
                                    %if cell is not None:
                                        background-color: ${styles_map[cell.patch_type]};
                                        % for orientation, edge_type in cell.edges.items():
                                            border-${styles_map[orientation]}-style: ${styles_map[edge_type]};
                                            border-${styles_map[orientation]}-color: ${styles_map['edge_color'][edge_type]};
                                        % endfor
                                        % if cell.activity is not None:
                                            background-image:
                                                    radial-gradient(${styles_map['activity_color'][cell.activity.activity_type]} 7%,
                                                    transparent 90%);
                                        % endif
                                    %endif
                               "
                            >
                               <span style="color: #686c6d">
                                   (${col_idx},${row_idx})
                               </span><br>
                               <span>
                                   %if cell is not None and cell.text is not None:
                                        <span style="font-size: 8px"><b>${cell.text}</b></span>
                                   %endif
                               </span>

                            </div>
                       </div>
                    %endfor
                </div>
            %endfor
        </div>
    %endfor
</div>


</body>
</html>
