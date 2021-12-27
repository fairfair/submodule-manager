# Gestionnaire de sous module

Installez ce dépot à la racine de votre projet.

### Installer les dépendences

Dans le submodule.json

```json
[
    {
        "name": "Container",
        "repository": "git@github.com:romainlavabre/spring-starter-container.git",
        "tag": "1.[0-9]*.[0-9]*",
        "scriptExecution": "auto|manual|none",
        "target": "/src/main/java/com/replace/replace/api/container"
    }
]
```

Ou 

<table>
    <tr>
        <th>name</th>
        <td>Nom arbitraire de votre dépendence (doit etre unique)</td>
    </tr>
    <tr>
        <th>repository</th>
        <td>Lien vers votre dépot</td>
    </tr>
    <tr>
        <th>tag</th>
        <td>La version cible de votre dépendence, peut être une regex</td>
    </tr>
    <tr>
        <th>scriptExecution</th>
        <td>
            Si auto, les scripts d'installation (des dépendences) seront automatiquement installées, si manuel, cela vous sera demandé pour chaque dépendence, si none, aucun script n'est exécuté.
        </td>
    </tr>
    <tr>
        <th>target</th>
        <td>Le dossier cible (le dépot sera cloné à l'interieur)</td>
    </tr>
</table>

Puis lancez 

```shell script
./submodule --install
./submodule -i
```

De la même manière, si vous ajoutez une dépendence ou modifiez une version, lancez

```shell script
./submodule --update
./submodule -u
```  

### Verifiez les versions / conflits

```shell script
./submodule --check-dependency
./submodule -cd
```  

Il vous sera indiqué si des dépendences ont elles-mêmes d'autre dépendence ou qu'une version est en conflit

### Modifier les sources d'un sous module

```shell script
./submodule --modify {name}
./submodule -m {name}
```  

Cette commande vous permet de vous attacher au dépot distant pour modifier le code source de votre dépendence

### Créer une dépendence

A la racine de votre projet, vous pouvez placer un install.sh.
Il sera automatiquement exécuté a chaque installation (selon la configuration du client).

De la même manière, si votre projet contient des dépendences (sub module), vous pouvez le spécifier dans dependency.json

```json
[
    {
        "repository": "git@github.com:romainlavabre/spring-starter-environment.git",
        "tag": "1.0.0"
    }
]
```

Le client en sera informé.

Pour information, le install.sh sera supprimé après l'installation.