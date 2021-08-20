<?php
session_start();

try{

    $bdd = new PDO("mysql:host=localhost;dbname=wesh" , "root", "");

}catch(PDOException $e){

    echo $e->getMessage();

}

// var_dump($_POST);
$erreurIn = "";
$erreurCo = "";
$successIn = "";
$successCo = "";

if(isset($_POST["submit"])){
    
    $email = htmlspecialchars($_POST['email']);
    $mdp =  htmlspecialchars ($_POST['mdp']);
    $mdp2 = htmlspecialchars ($_POST['mdp2']);

    // $uppercase = preg_match('@[A-Z]@', $mdp);
    // $lowercase = preg_match('@[a-z]@', $mdp);
    // $number = preg_match('@[0-9]@', $mdp);

    if(!empty($email) && !empty($mdp) && !empty($mdp2)){
    
        if(filter_var($email, FILTER_VALIDATE_EMAIL)){
            
                if($mdp == $mdp2){

                    $select = $bdd->prepare("SELECT * FROM users WHERE email = ?");
                    $select->execute([$email]);

                    $count = $select->rowCount();

                    if($count === 0){

                        $mdphash = password_hash($mdp, PASSWORD_DEFAULT);

                        $insert = $bdd->prepare("INSERT INTO users(email, mdp) VALUES(?, ?)");
                        $insert->execute([$email, $mdphash]);

                        $successIn = "Bienvenue dans Wesh la boutique fraiche !";

                    }else{
                        $erreurIn = "Un compte existe déjà utilisant cet email !";
                    }

                }else{
                    $erreurIn = "Les mots de passes ne sont pas identiques !";
                }

        }else{
            $erreurIn = "Veuillez entrer un email valide !";
        }

    }else{
        $erreurIn = "Veuillez remplir tout les champs !";
    }
}

// ------------------------------------------------------------Connexion--------------------------------------------------------------------------------------------

if(isset($_POST["submitConnexion"])){

    $email = htmlspecialchars($_POST['email']);
    $mdp =  htmlspecialchars ($_POST['mdp']);

    if(!empty($email) && !empty($mdp)){

        if(filter_var("$email, FILTER_VALIDATE_EMAIL")){

            $select = $bdd->prepare("SELECT * FROM users WHERE email = ?");
            $select->execute([$email]);

            $result = $select->fetch();

            if($result !== false){

                $mdpBdd = $result["mdp"];

                if(password_verify($mdp,$mdpBdd)){

                    $_SESSION["email"] = $result["email"]; 

                    header("Location: boutique.php");

                }else{
                    $erreurCo = "Le mot de passe est incorrect !";
                }

            }else{
                $erreurCo = "L'email est incorrect !";
            }

        }else{
            $erreurCo = "Veuillez utiliser un email valide !";
        }

    }else{
        $erreurCo = "Veuillez remplir tout les champs !";
    }
}

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
            Wesh Shop
        </div>

        <div>
            <a href="">Home</a>
            <a href="">Inscription/connexion</a>
        </div>
    </nav>

    <div class="main">
       
        <h1>WESH BOUTIQUE</h1>
        
    </div>
    
    <div class="form">
        <div class="inscription">

            <form action="" method="POST">

                <h4> <div class="erreur"> <?php echo $erreurIn; ?> </div> <div class="success"> <?php echo $successIn; ?> </div> </h4>
                
                <input type="email" name="email" placeholder="Entrez un email">
                <input type="password" name="mdp" placeholder="Entrez votre mot de passe">
                <input type="password" name="mdp2" placeholder="Confirmez votre mot de passe">
                <input type="submit" name="submit">

            </form>
        
        </div>
        
        <div class="connexion">
            
            <form action="" method="POST">

                <h4> <div class="erreur"> <?php echo $erreurCo; ?> </div> <div class="success"> <?php echo $successCo; ?> </div> </h4>
                
                <input type="email" name="email" placeholder="Entrez un email">
                <input type="password" name="mdp" placeholder="Entrez votre mot de passe">
                <input type="submit" name="submitConnexion">

            </form>

        </div>

    </div>

</body>
</html>