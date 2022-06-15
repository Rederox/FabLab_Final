<!DOCTYPE html>
<html lang="en">

<head>
  <!-- Required meta tags -->
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>FabLab</title>
  <!-- plugins:css -->
  <link rel="stylesheet" href="../../vendors/mdi/css/materialdesignicons.min.css">
  <link rel="stylesheet" href="../../vendors/feather/feather.css">
  <link rel="stylesheet" href="../../vendors/ti-icons/css/themify-icons.css">
  <link rel="stylesheet" href="../../vendors/css/vendor.bundle.base.css">
  <link rel="stylesheet" href="../../pages/tag_nfc/css/style.css">
  <link rel="stylesheet" href="select/css/awselect.css">

  <!-- endinject -->
  <!-- Plugin css for this page -->
  <!-- End plugin css for this page -->
  <!-- inject:css -->
  <link rel="stylesheet" href="../../css/vertical-layout-light/style.css">
  <!-- endinject -->
  <link rel="shortcut icon" href="../../images/favicon.png" />

  <meta http-Equiv="Cache-Control" Content="no-cache" />
  <meta http-Equiv="Pragma" Content="no-cache" />
  <meta http-Equiv="Expires" Content="0" />

</head>

<body>
  <div class="container-scroller">
    <!-- partial:../../partials/_navbar.html -->
    <nav class="navbar col-lg-12 col-12 p-0 fixed-top d-flex flex-row">
      <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-center">
        <a class="navbar-brand brand-logo mr-5" href="../../"><img src="../../images/logo.svg" class="mr-2" alt="logo" /></a>
        <a class="navbar-brand brand-logo-mini" href="../../"><img src="../../images/logo-mini.svg" alt="logo" /></a>
      </div>
      <div class="navbar-menu-wrapper d-flex align-items-center justify-content-end">
        <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-toggle="minimize">
          <span class="icon-menu"></span>
        </button>

        <ul class="navbar-nav navbar-nav-right">
          <li class="nav-item nav-profile dropdown">
            <a class="btn btn-inverse-danger btn-fw" href="../login/deconnecter.php">
              <i class="ti-power-off text-primary"></i>
              Logout
            </a>
          </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-toggle="offcanvas">
          <span class="icon-menu"></span>
        </button>
      </div>
    </nav>
    <!-- partial -->
    <div class="container-fluid page-body-wrapper">
      <!-- partial:../../partials/_settings-panel.html -->
      <div class="theme-setting-wrapper">
        <div id="settings-trigger"><i class="ti-settings"></i></div>
        <div id="theme-settings" class="settings-panel">
          <i class="settings-close ti-close"></i>
          <p class="settings-heading">SIDEBAR SKINS</p>
          <div class="sidebar-bg-options selected" id="sidebar-light-theme">
            <div class="img-ss rounded-circle bg-light border mr-3"></div>Light
          </div>
          <div class="sidebar-bg-options" id="sidebar-dark-theme">
            <div class="img-ss rounded-circle bg-dark border mr-3"></div>Dark
          </div>
          <p class="settings-heading mt-2">HEADER SKINS</p>
          <div class="color-tiles mx-0 px-4">
            <div class="tiles success"></div>
            <div class="tiles warning"></div>
            <div class="tiles danger"></div>
            <div class="tiles info"></div>
            <div class="tiles dark"></div>
            <div class="tiles default"></div>
          </div>
        </div>
      </div>
      <!-- partial -->
      <!-- partial:../../partials/_sidebar.html -->
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <li class="nav-item ">
            <a class="nav-link" href="../../">
              <i class="icon-grid menu-icon"></i>
              <span class="menu-title">Dashboard</span>
            </a>
          </li>
          <li class="nav-item ">
            <a class="nav-link" href="../../pages/adherent">
              <i class="icon-head menu-icon"></i>
              <span class="menu-title">Gestion des adhérents </span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../../pages/Notices/">
              <i class=" icon-paper menu-icon"></i>
              <span class="menu-title">Gestion des Notices </span>
            </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="../../pages/tag_nfc/">
              <i class="icon-tag menu-icon"></i>
              <span class="menu-title">Gestion des tag NFC </span>
            </a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="../../pages/stats">
              <i class="icon-pie-graph menu-icon"></i>
              <span class="menu-title">Stats d'utilisation </span>
            </a>
          </li>

        </ul>
      </nav>
      <!-- partial -->

      <div class="main-panel">
        <div class="content-wrapper">

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Sélectionner une date</h4>

                  <?php
                  setlocale(LC_TIME, 'fr_FR.utf8', 'fra');
                  $date = strftime("%y-%m-%d");


                  ?>
                  <form action="index.php" method="post">
                    <table>
                      <tr>
                        <td>
                          <select name=year>
                            <option value='2020'>2020</option>
                            <option value='2021'>2021</option>
                            <option value='2022'>2022</option>
                            <option value='2023'>2023</option>
                            <option value='2024'>2024</option>
                            <option value='2025'>2025</option>
                            <option value='2026'>2026</option>
                            <option value='2027'>2027</option>
                            <option value='2028'>2028</option>
                            <option value='2029'>2029</option>
                            <option value='2030'>2030</option>
                            <option value='2031'>2031</option>
                            <option value='2032'>2032</option>
                            <option value='2033'>2033</option>
                            <option value='2034'>2034</option>
                            <option value='2035'>2035</option>
                            <option value='2036'>2036</option>
                            <option value='2037'>2037</option>
                            <option value='2038'>2038</option>
                            <option value='2039'>2039</option>
                            <option value='2040'>2040</option>
                            <option value='2041'>2041</option>
                            <option value='2042'>2042</option>
                            <option value='2043'>2043</option>
                            <option value='2044'>2044</option>
                            <option value='2045'>2045</option>
                            <option value='2046'>2046</option>
                            <option value='2047'>2047</option>
                            <option value='2048'>2048</option>
                            <option value='2049'>2049</option>
                            <option value='2050'>2050</option>
                          </select>
                        </td>

                        <td>
                          <select name=month>
                            <option value='01'>Janvier</option>
                            <option value='02'>Février</option>
                            <option value='03'>Mars</option>
                            <option value='04'>Avril</option>
                            <option value='05'>Mai</option>
                            <option value='06'>Juin</option>
                            <option value='07'>Juillet</option>
                            <option value='08'>Août</option>
                            <option value='09'>Septembre</option>
                            <option value='10'>Octobre</option>
                            <option value='11'>Novembre</option>
                            <option value='12'>Decembre</option>
                          </select>
                        </td>

                        <td>
                          <select name=day>
                            <option value='01'>01</option>
                            <option value='02'>02</option>
                            <option value='03'>03</option>
                            <option value='04'>04</option>
                            <option value='05'>05</option>
                            <option value='06'>06</option>
                            <option value='07'>07</option>
                            <option value='08'>08</option>
                            <option value='09'>09</option>
                            <option value='10'>10</option>
                            <option value='11'>11</option>
                            <option value='12'>12</option>
                            <option value='13'>13</option>
                            <option value='14'>14</option>
                            <option value='15'>15</option>
                            <option value='16'>16</option>
                            <option value='17'>17</option>
                            <option value='18'>18</option>
                            <option value='19'>19</option>
                            <option value='20'>20</option>
                            <option value='21'>21</option>
                            <option value='22'>22</option>
                            <option value='23'>23</option>
                            <option value='24'>24</option>
                            <option value='25'>25</option>
                            <option value='26'>26</option>
                            <option value='27'>27</option>
                            <option value='28'>28</option>
                            <option value='29'>29</option>
                            <option value='30'>30</option>
                            <option value='31'>31</option>
                          </select>
                        </td>

                        <br>
                        <td>
                          <input type="submit" value="Envoyer">
                        </td>

                      </tr>
                    </table>
                  </form>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title"></h4>

                  <?php


                  $con  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
                  if (!$con) {
                    echo "<table>";
                    echo "<tr>";
                    echo "<th>";
                    echo "phpMyAdmin Status";
                    echo "</th>";
                    echo "</tr>";

                    echo "<tr>";
                    echo "<td>";
                    echo "Problem in database connection! Contact administrator!";
                    echo "</td>";
                    echo "</tr>";
                    echo "</table>";
                  } else {
                    $year = $_POST['year'];
                    $month = $_POST['month'];
                    $day = $_POST['day'];
                    $date = $year . $month . $day;

                    if ($date == "") {
                      setlocale(LC_TIME, 'fr_FR.utf8', 'fra');
                      $date = strftime("%y%m%d");
                    }
                    echo "<table>";
                    echo "<tr>";
                    echo "<th>";
                    echo "phpMyAdmin Status";
                    echo "</th>";
                    echo "</tr>";

                    echo "<tr>";
                    echo "<td>";
                    echo "Connected !";
                    echo "</td>";
                    echo "</tr>";
                    echo "</table>";
                  }
                  ?>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title"></h4>

                  <?php
                  $con  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
                  if (!$con) {
                    echo "<table>";
                    echo "<tr>";
                    echo "<th>";
                    echo "phpMyAdmin Status";
                    echo "</th>";
                    echo "</tr>";

                    echo "<tr>";
                    echo "<td>";
                    echo "Problem in database connection! Contact administrator!";
                    echo "</td>";
                    echo "</tr>";
                    echo "</table>";
                  } else {
                    $year = $_POST['year'];
                    $month = $_POST['month'];
                    $day = $_POST['day'];
                    $date = $year . $month . $day;

                    echo "<table>";
                    echo "<tr>";
                    echo "<th>";
                    echo "Date";
                    echo "</th>";
                    echo "</tr>";

                    echo "<tr>";
                    echo "<td>";
                    if ($date == "") {
                      setlocale(LC_TIME, 'fr_FR.utf8', 'fra');
                      echo strftime("%y-%m-%d");
                    } else {
                      echo $year . "-" . $month . "-" . $day;
                    }
                    echo "</td>";
                    echo "</tr>";
                    echo "</table>";
                    if ($date == "") {
                      setlocale(LC_TIME, 'fr_FR.utf8', 'fra');
                      $date = strftime("%y%m%d");
                    }
                  }
                  ?>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">

                  <h4 class="card-title">Etat des machines</h4>
                  <div class="table-responsive">
                    <table class="table">

                      <thead>
                        <tr>
                          <th>Nom de l'appareil</th>
                          <th>Etat</th>
                          <th>Maintenance</th>
                        </tr>
                      </thead>

                      <tbody>

                        <?php
                        $con3  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
                        $sql3 = "SELECT A.Nom_appareil, E.Etat, E.maintenance FROM Etat_appareil E, Appareil A WHERE E.Numero_appareil=A.Numero_appareil";
                        $result3 = mysqli_query($con3, $sql3);

                        while ($row3 = mysqli_fetch_assoc($result3)) {
                          echo "<tr>";

                          echo "<td>";
                          echo $row3['Nom_appareil'];
                          echo "</td>";

                          echo "<td>";
                          echo $row3['Etat'];
                          echo "</td>";

                          echo "<td>";
                          echo $row3['maintenance'];
                          echo "</td>";

                          echo "</tr>";
                        }

                        /*mysqli_free_result($result3);	
			mysqli_close($con3);*/
                        ?>




                      </tbody>
                    </table>
                  </div>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">

                  <h4 class="card-title">Temps d'utilisation des machines</h4>
                  <div class="table-responsive">
                    <table class="table">

                      <thead>
                        <tr>
                          <th>Nom de l'appareil</th>
                          <th>Heure début</th>
                          <th>Heure fin</th>
                          <th>Durée totale</th>
                          <th>Nom</th>
                          <th>Prénom</th>
                          <th>Date</th>
                        </tr>
                      </thead>

                      <tbody>

                        <?php

                        $con  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
                        $sql = "SELECT A.Nom_appareil, H.Heure_debut, H.Heure_fin, H.Duree_totale, H.Nom, H.Prenom, H.Jour FROM Appareil A, Historique H WHERE A.Numero_appareil=H.Numero_appareil AND H.Jour=$date";
                        $result = mysqli_query($con, $sql);

                        while ($row = mysqli_fetch_assoc($result)) {
                          echo "<tr>";
                          echo "<td>";
                          echo $row['Nom_appareil'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Heure_debut'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Heure_fin'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Duree_totale'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Nom'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Prenom'];
                          echo "</td>";

                          echo "<td>";
                          echo $row['Jour'];
                          echo "</td>";

                          echo "</tr>";
                        }

                        /*mysqli_free_result($result);	
			mysqli_close($con);*/
                        ?>

                      </tbody>
                    </table>
                  </div>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Représentation Graphique Du Temps D'utilisation Des Machines</h4>
                  <div id="exampleAppareil" style="height: 250px;"></div>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">

                  <h4 class="card-title">Temps de précense des membres du FABLAB</h4>
                  <div class="table-responsive">
                    <table class="table">

                      <thead>
                        <tr>
                          <th>Nom</th>
                          <th>Prénom</th>
                          <th>Heure début</th>
                          <th>Heure fin</th>
                          <th>Temps passé au FABLAB</th>
                          <th>Date</th>
                        </tr>
                      </thead>

                      <tbody>

                        <?php
                        $con2  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
                        $sql2 = "SELECT Nom, Prenom, HeureEntree, HeureSortie, DureeTotalPresence, Jour FROM inscrit_fablab_log WHERE Jour=\"$date\"";
                        $result2 = mysqli_query($con2, $sql2);

                        while ($row2 = mysqli_fetch_assoc($result2)) {
                          echo "<tr>";

                          echo "<td>";
                          echo $row2['Nom'];
                          echo "</td>";

                          echo "<td>";
                          echo $row2['Prenom'];
                          echo "</td>";

                          echo "<td>";
                          echo $row2['HeureEntree'];
                          echo "</td>";

                          echo "<td>";
                          echo $row2['HeureSortie'];
                          echo "</td>";

                          echo "<td>";
                          echo $row2['DureeTotalPresence'];
                          echo "</td>";

                          echo "<td>";
                          echo $row2['Jour'];
                          echo "</td>";

                          echo "</tr>";
                        }

                        /*mysqli_free_result($result2);	
			mysqli_close($con2);*/
                        ?>

                      </tbody>
                    </table>
                  </div>

                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-12 grid-margin stretch-card">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title">Représentation Graphique Du Temps de précense des membres du FABLAB</h4>
                  <div id="exampleMembres" style="height: 250px;"></div>

                </div>
              </div>
            </div>
          </div>

        </div>


        <!-- content-wrapper ends -->
        <!-- partial:../../partials/_footer.html -->
        <footer class="footer">
          <div class="d-sm-flex justify-content-center justify-content-sm-between">
            <span class="text-muted text-center text-sm-left d-block d-sm-inline-block">Fablab © 2022.</span>
            <span class="float-none float-sm-right d-block mt-1 mt-sm-0 text-center">Merci BTS SNIR <i class="ti-heart text-danger ml-1"></i></span>
          </div>
        </footer>
        <!-- partial -->
      </div>
      <!-- main-panel ends -->
    </div>
    <!-- page-body-wrapper ends -->
  </div>


  <!-- container-scroller -->
  <!-- plugins:js -->
  <script src="../../vendors/js/vendor.bundle.base.js"></script>
  <!-- endinject -->
  <!-- Plugin js for this page -->
  <!-- End plugin js for this page -->
  <!-- inject:js -->
  <script src="../../js/off-canvas.js"></script>
  <script src="../../js/hoverable-collapse.js"></script>
  <script src="../../js/template.js"></script>
  <script src="../../js/settings.js"></script>
  <script src="../../js/todolist.js"></script>
  <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <!-- endinject -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="js/NFC_read_delete.js"></script>
  <script src="../tag_nfc/js/NFC_write.js"></script>
  <script type="text/javascript" src="select/js/awselect.js"></script>

  <script type="text/javascript">
    google.charts.load("current", {
      packages: ["timeline"]
    });
    google.charts.setOnLoadCallback(drawChartAppareil);
    google.charts.setOnLoadCallback(drawChartMembres);

    function drawChartAppareil() {

      var container = document.getElementById('exampleAppareil');
      var chart = new google.visualization.Timeline(container);
      var dataTable = new google.visualization.DataTable();
      dataTable.addColumn({
        type: 'string',
        id: 'Room'
      });
      dataTable.addColumn({
        type: 'string',
        id: 'Name'
      });
      dataTable.addColumn({
        type: 'date',
        id: 'Start'
      });
      dataTable.addColumn({
        type: 'date',
        id: 'End'
      });
      dataTable.addRows([

        <?php

        $con4  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
        $sql4 = "SELECT H.Nom, H.Prenom, A.Nom_appareil, TIME_FORMAT(H.Heure_debut, '%H') as heureDebut, TIME_FORMAT(H.Heure_debut, '%i') as minuteDebut, TIME_FORMAT(H.Heure_debut, '%s') as secondeDebut, TIME_FORMAT(H.Heure_fin, '%H') as heureFin, TIME_FORMAT(H.Heure_fin, '%i') as minuteFin, TIME_FORMAT(H.Heure_fin, '%s') as secondeFin, DATE_FORMAT(H.Jour,'%Y') as annee, DATE_FORMAT(H.Jour, '%c') as mois, DATE_FORMAT(H.Jour, '%d') as jour FROM Historique H, Appareil A WHERE H.Numero_appareil=A.Numero_appareil AND Jour=$date";
        $query4 = mysqli_query($con4, $sql4);

        while ($result4 = mysqli_fetch_assoc($query4)) {

          echo "['" . $result4['Nom_appareil'] . "', '" . $result4['Nom'] . " " . $result4['Prenom'] . "',  new Date (" . $result4['annee'] . ", " . $result4['mois'] . ", " . $result4['jour'] . ", " . $result4['heureDebut'] . ",  " . $result4['minuteDebut'] . ",  " . $result4['secondeDebut'] . "), new Date (" . $result4['annee'] . ",  " . $result4['mois'] . ", " . $result4['jour'] . ",  " . $result4['heureFin'] . ", " . $result4['minuteFin'] . ", " . $result4['secondeFin'] . ") ],";
        }

        /*mysqli_free_result($result4);	
				mysqli_close($con4);*/

        ?>

      ]);

      var options = {
        timeline: {
          colorByRowLabel: true
        },
        //backgroundColor: '#ffd'
      };

      chart.draw(dataTable, options);
    }

    function drawChartMembres() {

      var container = document.getElementById('exampleMembres');
      var chart = new google.visualization.Timeline(container);
      var dataTable = new google.visualization.DataTable();

      dataTable.addColumn({
        type: 'string',
        id: 'Room'
      });
      dataTable.addColumn({
        type: 'string',
        id: 'Name'
      });
      dataTable.addColumn({
        type: 'date',
        id: 'Start'
      });
      dataTable.addColumn({
        type: 'date',
        id: 'End'
      });
      dataTable.addRows([

        <?php

        $con5  = mysqli_connect("localhost", "fablab", "Fablab.123admin", "fablab");
        $sql5 = "SELECT Nom, Prenom, TIME_FORMAT(HeureEntree, '%H') as heureDebut2, TIME_FORMAT(HeureEntree, '%i') as minuteDebut2, TIME_FORMAT(HeureEntree, '%s') as secondeDebut2,TIME_FORMAT(HeureSortie, '%H') as heureFin2, TIME_FORMAT(HeureSortie, '%i') as minuteFin2, TIME_FORMAT(HeureSortie, '%s') as secondeFin2, DATE_FORMAT(Jour,'%Y') as annee2, DATE_FORMAT(Jour, '%c') as mois2, DATE_FORMAT(Jour, '%d') as jour2 FROM inscrit_fablab_log WHERE Jour=$date";

        $query5 = mysqli_query($con5, $sql5);


        while ($result5 = mysqli_fetch_assoc($query5)) {

          echo "['Temps passé au FABLAB', '" . $result5['Nom'] . " " . $result5['Prenom'] . "',  new Date (" . $result5['annee2'] . ", " . $result5['mois2'] . ", " . $result5['jour2'] . ", " . $result5['heureDebut2'] . ",  " . $result5['minuteDebut2'] . ",  " . $result5['secondeDebut2'] . "), new Date (" . $result5['annee2'] . ",  " . $result5['mois2'] . ", " . $result5['jour2'] . ",  " . $result5['heureFin2'] . ", " . $result5['minuteFin2'] . ", " . $result5['secondeFin2'] . ") ],";
        }

        /*mysqli_free_result($result5);	
				mysqli_close($con5);*/

        ?>

      ]);

      var options = {
        timeline: {
          singleColor: '#8d8'
        },
        //backgroundColor: '#ffd'
      };

      chart.draw(dataTable, options);
    }
  </script>




</body>

</html>