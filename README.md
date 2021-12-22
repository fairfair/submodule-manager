# Gestionnaire de sous module

Installez ce dépot à la racine de votre projet.

### Installer les dépendences

Dans le submodule.json

```json
[
    {
        "name": "Container",
        "repository": "git@github.com:romainlavabre/spring-starter-container.git",
        "tag": "1.0.0",
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
        <td>La version cible de votre dépendence</td>
    </tr>
    <tr>
        <th>scriptExecution</th>
        <td>
            Si auto, les scripts d'installation (des dépendences) seront automatiquement installé, si manuel, cela vous sera demandé pour chaque dépendence, si none, aucun script n'est exécuté.
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
```

De la même manière, si vous ajoutez une dépendence ou modifiez une version, lancez

```shell script
./submodule --update
```  

### Verifiez les versions / conflits

```shell script
./submodule --check-dependency
```  

Il vous sera indiqué si des dépendences ont elles-mêmes d'autre dépendence ou qu'une version est en conflit


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

Pour information, ces deux fichiers sont supprimés après l'installation.