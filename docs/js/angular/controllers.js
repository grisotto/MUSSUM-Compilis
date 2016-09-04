var app = angular.module("birlWeb", ['ui.ace']);


app.config(['$compileProvider', function ($compileProvider) {
    $compileProvider.aHrefSanitizationWhitelist(/^\s*(|blob|):/);
}]);

//CONTROLLERS

app.controller("birlCtrl", function($scope, $window, birlService) {
    $scope.disabled = false;
    $scope.btText = "Cacildiss!";
    $scope.stdin = "";
    $scope.stdout = "";
    $scope.code = "encasapa o lance\n    forevis (preto_inteiris 1)\{ \n \t\tleite; \n\t\t oia_aqui_oh (\"\%\s\", \&leite);\n "+
    " \t\tque_isso_rapa? (leite sarava \"meh\" ) \n"+
     "    \t\t\tmais_meh;\n \ \t} \ncacildis";
    $scope.temErro = false;

    // Tem leite de morcego? Não? Deus é testemunha de que eu queria leite, então bota uma pinga aí!

    $scope.sendBirl = function(){
        $scope.disabled = true;
        $scope.btText = "Buscando...";
        $scope.temErro = false;
        $scope.stdout = "";
        birlService.runBirl($scope.code, $scope.stdin).then(function(data){
            $scope.stdout = data;
        }, function(error){
            if(error == "server-error") {
                $scope.stdout = "AZULÃO NÃO, SAI DAQUE GALEGUS";
            } else {
                $scope.stdout = "ERRIS O COMPILIS CUMPADI";
            }
            $scope.temErro = true;
        }).finally(function(){
            $scope.disabled = false;
            $scope.btText = "Cacildiss!";
        });
    }

    var blob;

    //observar o codigo e alterar o blob
    $scope.$watch('code', function() {
        blob = new Blob([$scope.code], { type: 'text/plain' }),
        url = $window.URL || $window.webkitURL;
        $scope.fileUrl = url.createObjectURL(blob);
    });

});

//SERVICES

app.service("birlService", function($http, $q) {
    this.runBirl = function(code, stdin){
        var deferred = $q.defer();
        $http.post("https://birl.herokuapp.com/compile", {code: code, stdin: stdin }).then(function(response){
            data = response.data;
            if(data.error) {
                deferred.reject("compile-error");
            } else {
                deferred.resolve(data.stdout);
            }
        },function(error){
            deferred.reject("server-error");
        });
        return deferred.promise;
    }
});