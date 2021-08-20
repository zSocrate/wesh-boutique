<?php
session_start();

if(empty($_SESSION) || !isset($_SESSION["email"])){
    
    header("Location: deconnexion.php");
}

try{

    $bdd= new PDO("mysql:host=localhost;dbname=wesh;charset=utf8", "root", "");

}catch(PDOException $e){

    echo $e->getMessage();

}

$select = $bdd->prepare("SELECT * FROM articles");
$select->execute();

$resulat = $select->fetchAll();

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>

    <nav>
        <div>
            <?php echo $_SESSION["email"]; ?>
        </div>

        <div>
            <a href="">Home</a>
            <a href="deconnexion.php"> Se deconnecter </a>
        </div>
    </nav>

    <div class="main">
       
        <h1>WESH BOUTIQUE</h1>
        
    </div>

    <h1>Boutique</h1>
    <hr>

    <div class="produits">
        
        <?php

            foreach($resulat as $articles){

                echo '
                <div class="card">

                    <div class="haut">
                        <img src="assets/'. $articles['photo'].'" alt="">
                    </div>

                    <div class="bas">
                        <h2>'. $articles["nom"] .'</h2>

                        <p>'. $articles["description"] .'</p>

                        <p>'. $articles["prix"]. ' euros</p>';

                        if($articles["stock"] > 0){
                            echo '<p style=color:green>En Stock</p>
                                  <a href="">Voir en détails</a>
                                </div>
                            </div>';
                        }else{
                            echo '<p style="color:red">Stock épuisé</p>
                                  <a href="">Voir en détails</a>
                                </div>
                            </div>';
                        }
            }           

        ?>

    </div>
</body>
</html>