require('./../css/app.css');
require('./filters.js');
require('./language-changer.js');

var $ = require("jquery");
var _ = require("lodash");
var ngJsTree = require("ng-js-tree");

var webform = angular.module('nec-pam', [
    'ui.select',
    //'ngAnimate', Commented out because of a possible bug with ngAnimate that delays rendering of some elements.
    'ngSanitize',
    'ajoslin.promise-tracker',
    'angularSpinner',
    'pascalprecht.translate',
    'translate.languageChanger',
    'mm.foundation',
    'necdsFilter',
    'ngJsTree'
  ]);
  
webform.controller('NECsCtrl', ['$scope', '$rootScope', '$location', 'dataRepository', '$timeout', '$translate','$anchorScroll','$window','$filter', function($scope, $rootScope, $location, dataRepository, $timeout, $translate,$anchorScroll,$window,$filter) { 

    $scope.showPams = false;
    $scope.showOverview = true;
    $scope.treeData = [{}];

    $scope.treeData.sectorsData = require('./treeData/sectorsData.json');
    $scope.treeData.unionPolicyData = require('./treeData/unionPolicyData.json');
    $scope.treeData.pollutantsData = require('./treeData/pollutantsData.json');
    $scope.treeData.entitiesData = require('./treeData/entitiesData.json');
    $scope.treeData.policyInstrumentsData = require('./treeData/policyInstrumentsData.json');
    $scope.treeData.implementationStatusData = require('./treeData/implementationStatusData.json');
    $scope.treeData.projectionsScenarioData = require('./treeData/projectionsScenarioData.json');
    $scope.treeData.ammoniaEmissionsData = require('./treeData/ammoniaEmissionsData.json');
    $scope.treeData.ammoniumCarbonateFertilisersData = require('./treeData/ammoniumCarbonateFertilisersData.json');
    $scope.treeData.ammoniaEmissionsLivestockData = require('./treeData/ammoniaEmissionsLivestockData.json');
    $scope.treeData.openFieldBurningData = require('./treeData/openFieldBurningData.json');

    $scope.treeConfig = {
        
        animation: false,
        core: {
            "multiple": true,
            error: function(error) {
                $log.error('treeCtrl: error from js tree - ' + angular.toJson(error));
            }
        },
        plugins: ['checkbox'],
        checkbox: { whole_node: true}
    };

    $scope.treeConfigSingle = {
      animation: false,
      core: {
          "multiple" : false,
          error: function(error) {
              $log.error('treeCtrl: error from js tree - ' + angular.toJson(error));
          }
      },
      checkbox : {            
        deselect_all: true,
        three_state : false, 
      },
      plugins: ['checkbox'],
      checkbox: { whole_node: true}
    };

    $scope.readyCB = function(node, selected, event) {
      $scope.sectorsTreeInstance.jstree(true).hide_icons();
      $scope.pollutantsTreeInstance.jstree(true).hide_icons();
      $scope.unionPolicyTreeInstance.jstree(true).hide_icons();
      $scope.policyInstrumentsTreeInstance.jstree(true).hide_icons();
      $scope.implementationStatusTreeInstance.jstree(true).hide_icons();
      $scope.projectionsScenarioTreeInstance.jstree(true).hide_icons();
      $scope.ammoniaEmissionsTreeInstance.jstree(true).hide_icons();
      $scope.ammoniumCarbonateFertilisersTreeInstance.jstree(true).hide_icons();
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).hide_icons();
      $scope.openFieldBurningTreeInstance.jstree(true).hide_icons();
    }

    $scope.emptyUnionPolicyTreeInstance = function(node, selected, event) {
      $scope.unionPolicyTreeInstance.jstree(true).uncheck_all();
    }

    $scope.hideAgricultureObjects = function() {
      $scope.current.PAM.Table1.Agriculture.MeasuresControlAmmoniaEmissions = 'no';
      $scope.emptyMeasuresControlAmmoniaEmissionsObjects();
      $scope.current.PAM.Table1.Agriculture.FineParticulateMatterEmissions = 'no';
      $scope.emptyFineParticulateMatterEmissionsObjects();
      $scope.current.PAM.Table1.Agriculture.PreventingImpactsSmallFarms = 'no';
      $scope.emptyPreventingImpactsSmallFarmsObjects();
    }

    $scope.emptyMeasuresControlAmmoniaEmissionsObjects = function() {
      $scope.ammoniaEmissionsTreeInstance.jstree(true).uncheck_all();
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsPage = '';
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsExactlyReason = '';

      $scope.current.PAM.Table1.Agriculture.NationalNitrogenBudgetPage = '';
      $scope.current.PAM.Table1.Agriculture.NationalNitrogenBudgetExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.NationalNitrogenBudgetExactlyReason = '';

      $scope.ammoniumCarbonateFertilisersTreeInstance.jstree(true).uncheck_all();
      $scope.current.PAM.Table1.Agriculture.AmmoniumCarbonateFertilisersPage = '';
      $scope.current.PAM.Table1.Agriculture.AmmoniumCarbonateFertilisersExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.AmmoniumCarbonateFertilisersExactlyReason = '';

      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).uncheck_all();
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestockPage  = '';
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestockExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestockExactlyReason = '';
    }

    $scope.emptyFineParticulateMatterEmissionsObjects = function() {
      $scope.openFieldBurningTreeInstance.jstree(true).uncheck_all();
      $scope.current.PAM.Table1.Agriculture.OpenFieldBurningPage = '';
      $scope.current.PAM.Table1.Agriculture.OpenFieldBurningExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.OpenFieldBurningExactlyReason = "";

      $scope.current.PAM.Table1.Agriculture.NationalAdvisoryCodePage = '';
      $scope.current.PAM.Table1.Agriculture.NationalAdvisoryCodeExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.NationalAdvisoryCodeExactlyReason = "";
    }

    $scope.emptyPreventingImpactsSmallFarmsObjects = function() {
      $scope.current.PAM.Table1.Agriculture.ExemptSmallMicroFarmsPageExactly = 'yes';
      $scope.current.PAM.Table1.Agriculture.ExemptSmallMicroFarmsPageExactlyReason = "";
    }
  
    $scope.nodePollutantChanged = function(node, selected, event) {
      var nodes = selected.selected;
      //ng-show="current.PAM.Table1.Agriculture[0]. handle mandatory
      //mandatoryPollutant to handle the error message display on/off
      //$scope.current.treeDataClicked.mandatoryPollutant = 0;
      $scope.pollutantsTreeInstance.jstree(true).get_selected().forEach(function(node) {
        if ($scope.pollutantsTreeInstance.jstree(true).get_node(node).original.mandatory == 1) { 
          //$scope.current.treeDataClicked.mandatoryPollutant = 1;
        }
      });

      var pollutant = {};
      nodes.forEach(function(node) {
        if ($scope.pollutantsTreeInstance.jstree(true).get_node(node).children.length == 0) {
          //if ($scope.current.PAM.Table1.Pollutants.length == 0 || !($scope.current.PAM.Table1.Pollutants.find(o => o.Name === node))) {
          if ($scope.current.PAM.Table1.Pollutants.length == 0 || !(_.find($scope.current.PAM.Table1.Pollutants, function(o) { return o.Name === node; }))) {
            
            pollutant.Name = node;
            pollutant.Target2020 = null;
            pollutant.Target2025 = null;
            pollutant.Target2030 = null;
            $scope.current.PAM.Table1.Pollutants.push(pollutant);
          }
        }
        pollutant = {};
      });

      //removing Pollutants not selected from object
      $scope.current.PAM.Table1.Pollutants.forEach (function(pollutant) {
        if (!( _.find(nodes, function(o) { return o === pollutant.Name; }) )) {
        //if (!(nodes.find(o => o === pollutant.Name))) {
          $scope.current.PAM.Table1.Pollutants = $scope.current.PAM.Table1.Pollutants.filter(function(el){
            return el.Name !== pollutant.Name;
          });
        }
      })

      if (selected.node && selected.node.children.length > 0 && selected.selected.length > 0) {
        $scope.pollutantsTreeInstance.jstree(true).open_node(selected.node.id);  
      };
    }

    $scope.nodeSectorChanged = function(node, selected, event) {
        var nodes = selected.selected;
        var sector = {};
        var objective = {};

        $scope.current.PAM.Table1.Sectors = [];
        nodes.forEach(function(node) {
          if ($scope.sectorsTreeInstance.jstree(true).get_node(node).children.length !== 0) {
            //consider to remove sectores from object
            sector.Code = node;
            sector.Description = $scope.sectorsTreeInstance.jstree(true).get_text(node);
            $scope.current.PAM.Table1.Sectors.push(node);
          } else {
            //if ($scope.current.PAM.Table1.Objective.length == 0 || !($scope.current.PAM.Table1.Objective.find(o => o.Objective === node))) {
            if ($scope.current.PAM.Table1.Objective.length == 0 || !(_.find($scope.current.PAM.Table1.Objective, function(o) { return o.Objective === node; }))) {
              
              objective.Sector = $scope.sectorsTreeInstance.jstree(true).get_parent(node);
              objective.SectorDescription = $scope.sectorsTreeInstance.jstree(true).get_text($scope.sectorsTreeInstance.jstree(true).get_parent(node));
              objective.Objective = node;
              objective.ObjectiveDescription = $scope.sectorsTreeInstance.jstree(true).get_text(node);
              if (node.includes("_other")) {
                objective.ObjectiveDescription = '';
              }
              $scope.current.PAM.Table1.Objective.push(objective);
            }
          }
          objective = {};
        });

        //removing Objectives not selected from object
        $scope.current.PAM.Table1.Objective.forEach (function(objective) {
          if (!( _.find(nodes, function(o) { return o === objective.Objective; }) )) {
          //if (!(nodes.find(o => o === objective.Objective))) {
            $scope.current.PAM.Table1.Objective = $scope.current.PAM.Table1.Objective.filter(function(el){
              return el.Objective !== objective.Objective;
            });
          }
        })

        if (selected.node && selected.node.children.length > 0 && selected.selected.length > 0) {
          $scope.sectorsTreeInstance.jstree(true).open_node(selected.node.id);  
        };
    }

    $scope.nodePolicyInstrumentsChanged = function(node, selected, event) {
      $scope.current.PAM.Table1.PolicyInstruments = selected.selected;
    }

    $scope.nodeUnionPolicyChanged = function(node, selected, event) {
      var nodes = selected.selected;
      var unionPolicyType = {};
      var unionPolicy = {};

      nodes.forEach(function(node) {
        if ($scope.unionPolicyTreeInstance.jstree(true).get_node(node).children.length == 0) {
          //if ($scope.current.PAM.Table1.UnionPolicy.length == 0 || !($scope.current.PAM.Table1.UnionPolicy.find(o => o.UnionPolicy === node))) {
          if ($scope.current.PAM.Table1.UnionPolicy.length == 0 || !(  _.find($scope.current.PAM.Table1.UnionPolicy, function(o) { return o.UnionPolicy === node; })  )) {
            unionPolicy.UnionPolicyType = $scope.unionPolicyTreeInstance.jstree(true).get_parent(node);
            unionPolicy.UnionPolicyTypeDescription = $scope.unionPolicyTreeInstance.jstree(true).get_text($scope.unionPolicyTreeInstance.jstree(true).get_parent(node));
            unionPolicy.UnionPolicy = node;
            unionPolicy.UnionPolicyDescription = $scope.unionPolicyTreeInstance.jstree(true).get_text(node);
            if (node.includes("_other")) {
              unionPolicy.UnionPolicyDescription = '';
            }
            $scope.current.PAM.Table1.UnionPolicy.push(unionPolicy);
          }
        }
        unionPolicy = {};
      });

      //removing UnionPolicy not selected from object
      $scope.current.PAM.Table1.UnionPolicy.forEach (function(unionPolicy) {
        if (!( _.find(nodes, function(o) { return o === unionPolicy.UnionPolicy; }) )) {
          $scope.current.PAM.Table1.UnionPolicy = $scope.current.PAM.Table1.UnionPolicy.filter(function(el){
            return el.UnionPolicy !== unionPolicy.UnionPolicy;
          });
        }
      })      

      if (selected.node) {
        if (selected.node.children.length > 0 && selected.selected.length > 0) {
          $scope.unionPolicyTreeInstance.jstree(true).open_node(selected.node.id);  
        };
      };
    }

    $scope.nodeImplementationStatusChanged = function(node, selected, event) {
      $scope.current.PAM.Table1.Implementation[0].Status = selected.selected[0];
    }

    $scope.nodeProjectionsScenarioChanged = function(node, selected, event) {
      $scope.current.PAM.Table1.ProjectionsScenario = selected.selected;
    }

    $scope.nodeAmmoniaEmissionsChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissions = selected.selected;
    }

    $scope.nodeAmmoniumCarbonateFertilisersChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.Agriculture.AmmoniumCarbonateFertilisers = selected.selected;
    }


    $scope.nodeOpenFieldBurningChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.Agriculture.OpenFieldBurning = selected.selected;
    }

    $scope.nodeAmmoniaEmissionsLivestockChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestock = [];
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).get_selected().forEach(function(node) {
        if ( $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).is_leaf(node) === true) {
          $scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestock.push(node);
        }
      });
    }
    


    // Functions for model manipulation    
    var normalizeArray = function(obj, propertyName) {
      console.log('normalizeArray propertyName: ' + propertyName);

      var propertyValue = obj[propertyName];
      console.log('normalizeArray propertyValue: ' + propertyValue);   
      if (angular.isArray(propertyValue)) {
          return;
      }        
      if (angular.isUndefined(propertyValue) || propertyValue === null) {
          obj[propertyName] = [];
          return;
      }        

      var arrayValue = [];
      arrayValue.push(propertyValue);
      obj[propertyName] = arrayValue;
    };

    /*var nullToString = function(obj,prop) {
      if (obj[prop] === null) { obj[prop] = ""; }
    };*/

    // Add new row to ng-repeat
    $scope.addItem = function(path) {
        var tokens = path.split(".");
        var result = $scope.current.PAM;
        while(tokens.length) {
            result = result[tokens.shift()];
        }
        var copyOfEmptyInstance = angular.copy($scope.getInstanceByPath('emptyInstance.NEC_PAMs.NEC_PAM',path));      
        result.push(copyOfEmptyInstance);              
    };      
    
    /**
     * Urgent update for fixing old schema XML 
     * @param {type} path
     * @param {type} index
     * @returns {Boolean}
     */
    var performSchemaTransition = function(pam) {
      console.log('pam');
      console.log(pam);
      /*if (angular.isArray(pam.Table1.ObjectiveOther)) {
        pam.Table1.ObjectiveOther = {};
      }
      
      if (angular.isDefined(pam.Table1.ObjectiveOther.Sector)) {
        delete pam.Table1.ObjectiveOther.Sector;         
      }
      
      if (angular.isDefined(pam.Table1.ObjectiveOther.Text)) {
        delete pam.Table1.ObjectiveOther.Text;                      
      }*/
      
      var unionPolicyRelated = pam.Table1.UnionPolicyRelated;
      
      if (!unionPolicyRelated) {
        var unionPolicy = pam.Table1.UnionPolicy[0];
        if (unionPolicy === 'Non_EU-related_PAM') { 
          unionPolicyRelated = 'no';
          pam.Table1.UnionPolicy = [];
        }
        else unionPolicyRelated = 'yes';
      }
      else {
        delete pam.Table1.UnionPolicyRelated;
      }
      
      //var propsToShiftDown = ['UnionPolicyOther', 'Implementation', 'ProjectionsScenario', 'Entities', 'Indicators', 'Reference', 'Comments'];
      var propsToShiftDown = ['Implementation', 'ProjectionsScenario', 'Entities', 'Indicators', 'Reference', 'Comments'];
      var valuesToShiftDown = [];
      
      angular.forEach(propsToShiftDown, function(propName) {
        var value = pam.Table1[propName];
        valuesToShiftDown.push(value);
        
        if (angular.isDefined(value)) {
          delete pam.Table1[propName];
        }
      }); 

      for (var i = 0; i < propsToShiftDown.length; i++) {
        var prop = propsToShiftDown[i];
        var value = valuesToShiftDown[i];
        pam.Table1[prop] = value;
      }
    
      for (var i = 0; i < pam.Table1.Entities.length; i++) {
        if (!pam.Table1.Entities[i]) { 
          pam.Table1.Entities.splice(i, 1);
          i--;
        }
      }

      $scope.setRadioButtons(pam);
    };

    $scope.setRadioButtons = function(pam) { 
      pam.Table1.UnionPolicyRelated = "no";
      pam.Table1.Agriculture.AgriculturalRelated = "no";
      pam.Table1.Agriculture.NationalAirPollutionControl = "no";

      pam.Table1.Agriculture.MeasuresControlAmmoniaEmissions = "no";
      pam.Table1.Agriculture.AmmoniaEmissionsExactly = "yes";
      pam.Table1.Agriculture.MeasuresControlAmmoniaEmissionsExactly = "yes";
      pam.Table1.Agriculture.NationalNitrogenBudgetExactly = "yes";
      pam.Table1.Agriculture.AmmoniumCarbonateFertilisersExactly = "yes";
      pam.Table1.Agriculture.AmmoniaEmissionsLivestockExactly = "yes"

      pam.Table1.Agriculture.FineParticulateMatterEmissions = "no";
      pam.Table1.Agriculture.OpenFieldBurningExactly = "yes";
      pam.Table1.Agriculture.NationalAdvisoryCodeExactly = "yes";

      pam.Table1.Agriculture.PreventingImpactsSmallFarms = "no";
      pam.Table1.Agriculture.ExemptSmallMicroFarmsPageExactly = "yes";
    };
       
    /**
     * Remove row from ng-repeat.
     * @param {String} path
     * @param {Number} index
     * @returns {Boolean}
     */
    $scope.removeItem = function(path, index){
        if (!confirm('Are you sure you want to delete the data in this row?')){
          return false;
        }
        var tokens = path.split(".");
        var result = $scope.current.PAM;
        while(tokens.length) {
            result = result[tokens.shift()];
        }
        result.splice(index, 1);
        return true;
    };

    /**
     * Gets Object from String
     * @param {String} root
     * @param {String} identifier
     * @returns {Object}
     */
    $scope.getInstanceByPath = function(root, identifier) {
      if (!$scope.instance) {
          return null;
      }
      var tokens = root.split(".");
      var result = $scope;
      while(tokens.length) {
          result = result[tokens.shift()];
          if (!result) {
              return null;
          }
      }
      tokens = identifier.split(".");
      while(tokens.length) {
          result = result[tokens.shift()];
      }
      return result;
    };
        
    //Regular Expression Patterns
    $scope.regex = {};
    //$scope.regex.url = /^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$/;
    //$scope.regex.yearOrYears = /^[0-9]{4}(?:\s*,\s*[0-9]{4})*$/;
    $scope.regex.yearOrYears = /^[0-9]{4}(?:\s*-\s*[0-9]{4})?$/;
    
    /**
     * Utility to get Index of Object
     * @returns {Number} -1 if not found, else returns position of item in the array
     */
    var objectIndexOf = function(arr, obj) {
      for (var i = 0; i < arr.length; i++) {
        if (angular.equals(arr[i],obj)) return i;
      }
      return -1;
    };

    /**
     * Sets default values to temp objects
     *
     */
    $scope.defaultTempValues = function() {
      $scope.temp.SaveDisabled = false;
      $scope.temp.disableWatchers = false;      
    };
    
    $scope.temp = {};
    $scope.defaultTempValues();
    //ng-show="current.PAM.Table1.Agriculture[0].: Replace with modal functions
    $scope.alerts = [];
    
    $scope.emptyTables = {};
    $scope.current = {};    
    
    //Enable Validation by default
    $scope.ValidationEnabled = true;
        
    dataRepository.getEmptyInstance()
            .error(function(){alert("Failed to read empty instance XML file."); })
            .success(function(instance) {                                                            
              $scope.emptyInstance = instance;   
            });
    
    dataRepository.getInstance()
            .error(function(){alert("Failed to read instance XML file.");})
            .success(function(instance) {
            if (!angular.isDefined(instance)) { return; }

              console.log('instance');
              console.log(instance);
              //Modify Object to use arrays properly
              console.log('getInstance instance.NEC_PAMs');
              console.log(instance.NEC_PAMs);   
              normalizeArray(instance.NEC_PAMs,"NEC_PAM");
              for (var i = 0;i < instance.NEC_PAMs.NEC_PAM.length;i++) {
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"PolicyGroup");          
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Sectors");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Pollutants");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Objective");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"PolicyInstruments");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"UnionPolicy");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Implementation");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"ProjectionsScenario");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Entities");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Indicators");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Reference");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"PolicyImpact");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"ExanteDocumentation");
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"Expost");          
                normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"ExpostDocumentation");
                //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table3.Projected,"CostDocumentation");
                //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table3.Realised,"CostDocumentation");
                //nullToString(instance.NEC_PAMs.NEC_PAM[i],"Title");
                
                //performSchemaTransition(instance.NEC_PAMs.NEC_PAM[i]);
            }
            $scope.instance = {};
            $scope.instance.NEC_PAMs = {};
            //$scope.instance.NEC_PAMs['@xmlns:xsi'] = instance.NEC_PAMs['@xmlns:xsi'];
            //$scope.instance.NEC_PAMs['@xsi:noNamespaceSchemaLocation'] = instance.NEC_PAMs['@xsi:noNamespaceSchemaLocation'];

            if (!instance.NEC_PAMs['@xmlns:xsi']) $scope.instance.NEC_PAMs['@xmlns:xsi'] = 'http://www.w3.org/2001/XMLSchema-instance';                                   
            else $scope.instance.NEC_PAMs['@xmlns:xsi'] = instance.NEC_PAMs['@xmlns:xsi'];

            if (!instance.NEC_PAMs['@xmlns:noNamespaceSchemaLocation']) $scope.instance.NEC_PAMs['@xmlns:noNamespaceSchemaLocation'] = 'http://dd.eionet.europa.eu/schemas/mmr-pams/MMR_PAMs.xsd';                                   
            else $scope.instance.NEC_PAMs['@xmlns:noNamespaceSchemaLocation'] = instance.NEC_PAMs['@xmlns:noNamespaceSchemaLocation'];

            if (!instance.NEC_PAMs['@xml:lang']) $scope.instance.NEC_PAMs['@xml:lang'] = 'en';                                   
            else $scope.instance.NEC_PAMs['@xml:lang'] = instance.NEC_PAMs['@xml:lang'];
            if (!instance.NEC_PAMs['@labelLanguage']) $scope.instance.NEC_PAMs['@labelLanguage'] = 'en';    
            else $scope.instance.NEC_PAMs['@labelLanguage'] = instance.NEC_PAMs['@labelLanguage'];
            $scope.instance.NEC_PAMs.NEC_PAM = instance.NEC_PAMs.NEC_PAM;            
            var labelLang = $scope.instance.NEC_PAMs['@labelLanguage'];
            $rootScope.currentLanguage = labelLang;
            $timeout(function() { $scope.goOverview(); }, 100);
            console.log('getInstance $scope.instance.NEC_PAMs');
            console.log($scope.instance.NEC_PAMs);          
    });
                           
/*    $rootScope.$watch('currentLanguage', function(newValue, oldValue) {
        if (!newValue) {
            return;
        } else {
            $scope.instance.NEC_PAMs['@labelLanguage'] = $rootScope.currentLanguage;
            $scope.instance.NEC_PAMs['@xml:lang'] = $rootScope.currentLanguage;
        }
    });*/
    
    //Initialize empty scope
    $scope.instance = {};
    $scope.instance.NEC_PAMs = {};
    $scope.instance.NEC_PAMs.NEC_PAM = [];
    
   /**
    * Focus Overview Tab 
    *
    */
   $scope.goOverview = function() { 
      $scope.OverviewCalculate();
      $scope.OverviewValidate();
      
      $scope.showPams = false;
      $scope.showOverview = true;
      //$scope.setActiveTab(0);
   };
   
   /**
    * Detects if table is empty
    * @param {Number} index PAM
    * @param {Number} num Table
    * @returns {Boolean}
    */
   $scope.isEmpty = function(index,num) {
    if (!$scope.instance || !$scope.emptyInstance || index < 0) { return true; }     
    var tmpSingle = angular.copy(emptyTables['emptyTable' + num]);
    var tmpGroup = angular.copy(emptyTables['emptyTable' + num]);   
    var tmpTable = $scope.instance.NEC_PAMs.NEC_PAM[index]['Table' + num];
    if (num === 1) {
      tmpGroup.isGroup = 'group';
    }
    if (angular.equals(tmpTable,tmpSingle) || angular.equals(tmpTable,tmpGroup)) { return true; }
    else return false;    
   };

  /**
   * Returns true if Indicator has wrong year values
   * @param {Number} index
   * @returns {boolean} true if Indicator has wrong year values
   * 
   */
  $scope.hasIndicatorYearError = function(index) {
    var result = false;
    var path = "";
    for (var i = 1; i < 5; i++) {
     path = "table1_IndicatorYear" + index + "_" + i;
     if ($scope.Webform.Table1[path].$error.min || $scope.Webform.Table1[path].$error.max || $scope.Webform.Table1[path].$error.number) result = true;
    }
    return result;
  };

  //TODO
  $scope.setCurrentTreeData = function() {

    //$scope.current.PAM
    console.log('setCurrentTreeData $scope.current.PAM');
    console.log($scope.current.PAM);

    //$scope.current.PAM.Table1.Pollutants.Name

    if ($scope.current.PAM.Table1.Pollutants && $scope.current.PAM.Table1.Pollutants.len !== 0) {
      $scope.pollutantsTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.Pollutants.forEach (function(node) {
        $scope.pollutantsTreeInstance.jstree(true).select_node (node.Name , true, false);
      })
  
      $scope.sectorsTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.Objective.forEach (function(node) {
        $scope.sectorsTreeInstance.jstree(true).select_node (node.Sector , true, false);
        $scope.sectorsTreeInstance.jstree(true).select_node (node.Objective , true, false);
      })

      $scope.policyInstrumentsTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.PolicyInstruments.forEach (function(node) {
        $scope.policyInstrumentsTreeInstance.jstree(true).select_node (node , true, false);
      })

      $scope.implementationStatusTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.Implementation.forEach (function(node) {
        $scope.implementationStatusTreeInstance.jstree(true).select_node (node.Status , true, false);
      })

      $scope.unionPolicyTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.UnionPolicy.forEach (function(node) {
        $scope.unionPolicyTreeInstance.jstree(true).select_node (node.UnionPolicyType , true, false);
        $scope.unionPolicyTreeInstance.jstree(true).select_node (node.UnionPolicy , true, false);
      })

      $scope.projectionsScenarioTreeInstance.jstree(true).deselect_all(true);
      $scope.current.PAM.Table1.ProjectionsScenario.forEach (function(node) {
        $scope.projectionsScenarioTreeInstance.jstree(true).select_node (node , true, false);
      })

      $scope.ammoniaEmissionsTreeInstance.jstree(true).deselect_all(true);
      $scope.ammoniaEmissionsTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.Agriculture.AmmoniaEmissions , true, false);
      
      $scope.ammoniumCarbonateFertilisersTreeInstance.jstree(true).deselect_all(true);
      $scope.ammoniumCarbonateFertilisersTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.Agriculture.AmmoniumCarbonateFertilisers , true, false);
      
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).deselect_all(true);
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.Agriculture.AmmoniaEmissionsLivestock , true, false);
          
      $scope.openFieldBurningTreeInstance.jstree(true).deselect_all(true);
      $scope.openFieldBurningTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.Agriculture.OpenFieldBurning , true, false);
    }
  };

  /**
   * Changes current PAM
   * @param {Number} index
   *
   */
  $scope.setCurrentPam = function(id) {
    if (!$scope.instance.NEC_PAMs.NEC_PAM) { return; }
  
    for (var i = 0; i < $scope.instance.NEC_PAMs.NEC_PAM.length; i++) {
      if ($scope.instance.NEC_PAMs.NEC_PAM[i].internalId == id) {
        $scope.current.PAM = $scope.instance.NEC_PAMs.NEC_PAM[i];
        
        if ($scope.current.PAM.Table1.isGroup == 'single') {
          $scope.setCurrentTreeData();
        };

        break;
      }
    }


    if (!$scope.current.PAM) {
      $scope.current.PAM = $scope.instance.NEC_PAMs.NEC_PAM[0];
    }
    $scope.defaultTempValues();
    $timeout(function() { $scope.Webform.$setPristine(true); },0);
  };

  /**
   * Focuses on Table #num
   * @param {Number} index
   * @param {Number} num
   *
   */
  $scope.editTable = function(id, num) { 
     $scope.setCurrentPam(id);
     $scope.showOverview = false;
     $scope.showPams = true;
  };
  
  $scope.Overview = {};  
  $scope.Overview.Table = {};
  $scope.Overview.Table.empty1 = [];
  $scope.Overview.Table.empty2 = [];
  $scope.Overview.Table.empty3 = [];
  $scope.Overview.Table.text1 = [];
  $scope.Overview.Table.text2 = [];
  $scope.Overview.Table.text3 = [];
  // Functions for Groups
  $scope.Group = {};

  //Update PaM IDs in groups when a PaM changes ID  
  $scope.updateId = function(newId, oldId) {
    if (!$scope.isNullEmpty(newId) && newId !== oldId) {
      oldId = parseInt(oldId, 10);
      newId = parseInt(newId, 10);
      var tmp = null;
      for (var i = 0;i < $scope.instance.NEC_PAMs.NEC_PAM.length;i++) {
        if ($scope.instance.NEC_PAMs.NEC_PAM[i].Table1.isGroup === 'group' && $scope.instance.NEC_PAMs.NEC_PAM[i].internalId !== $scope.current.PAM.internalId) {
          $scope.temp.disableWatchers = true;
          //Policy groups
          tmp = $scope.instance.NEC_PAMs.NEC_PAM[i].Table1.PolicyGroup.indexOf(oldId);
          if (tmp !== -1) {
            $scope.instance.NEC_PAMs.NEC_PAM[i].Table1.PolicyGroup[tmp] = newId;
          }
          //Projections scenario
          tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM[i].Table1.ProjectionsScenario, {id: oldId}, true)[0];
          if (typeof tmp !== 'undefined') {
            tmp.id = newId; 
          }
          //Implementation period
          tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM[i].Table1.Implementation, {id: oldId}, true)[0];
          if (typeof tmp !== 'undefined') {
            tmp.id = newId;
          }
          $scope.temp.disableWatchers = false;
        }
      }
    }
  };

  //List of free IDs for the PaMs
  $scope.getAvailableIDs = function() {
    var ids = [];
    var maxId = 0;
    //Get current max PaM ID
    for (var i = 0; i < $scope.instance.NEC_PAMs.NEC_PAM.length; i++) {
      if ($scope.instance.NEC_PAMs.NEC_PAM[i].id > maxId) {
        maxId = $scope.instance.NEC_PAMs.NEC_PAM[i].id;
      }
    }
    //Get all available numbers from 1 to max+X
    var found = false;
    for (i = 1; i < maxId + 50; i++) {
      for(var j = 0; j < $scope.instance.NEC_PAMs.NEC_PAM.length; j++){
        if (i === $scope.instance.NEC_PAMs.NEC_PAM[j].id) {
          found = true;
        }
      }
      if (!found) {
        ids.push(i);  
      }
      found = false;
    }
    return ids;
  };

  //Function to get Grouped Sectors
  $scope.Group.getSectors = function(tempGroup) {
    var tmpSectors = [];
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      for (var j = 0;j < tmp.Sectors.length;j++) {    
        tmpSectors.push(tmp.Sectors[j]);        
      }        
    }
    $scope.current.PAM.Table1.Sectors = _.uniqWith(tmpSectors, _.isEqual);
  };
    
  //Function to get Grouped Pollutants
  $scope.Group.getPollutants = function(tempGroup) {
    var tmpPollutants = [];
    for (var i = 0;i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      for (var j = 0;j < tmp.Pollutants.length;j++) {    
        tmpPollutants.push(tmp.Pollutants[j]);        
      }       
    }
    $scope.current.PAM.Table1.Pollutants = _.uniqWith(tmpPollutants, _.isEqual);
    console.log('getObjectives $scope.current.PAM.Table1.Pollutants');
    console.log($scope.current.PAM.Table1.Pollutants);
  };
    
  //Function to get Grouped Objectives
  $scope.Group.getObjectives = function(tempGroup) {
    var tempObjective = [];
    for (var i = 0;i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      console.log('getObjectives tmp');
      console.log(tmp);
      for (var j = 0;j < tmp.Objective.length;j++) {
        tempObjective.push(tmp.Objective[j]);
      }
    }
    $scope.current.PAM.Table1.Objective = _.uniqWith(tempObjective, _.isEqual);
    console.log('getObjectives $scope.current.PAM.Table1');
    console.log($scope.current.PAM.Table1);
  };
       
  //Function to get Grouped Pollutants
  $scope.Group.getPolicyInstrument = function(tempGroup) {
    var tmpPolicyInstrument = [];
    for (var i = 0;i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      console.log('getObjectives tmp');
      console.log(tmp);
      if (angular.isDefined(tmp.PolicyInstrument)) {    
        for (var j = 0;j < tmp.PolicyInstrument.length;j++) {
          tmpPolicyInstrument.push(tmp.PolicyInstrument[j]);
        }
      }        
    }
    $scope.current.PAM.Table1.PolicyInstruments = _.uniqWith(tmpPolicyInstrument, _.isEqual);
    console.log('PolicyInstrument $scope.current.PAM.Table1');
    console.log($scope.current.PAM.Table1);
  };

  //Function to get Union Policies from individual PAMs
  $scope.Group.getUnionPolicies = function(tempGroup) {
    var tmpUnionPolicy = [];
    for (var i = 0;i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      console.log('getObjectives tmp');
      console.log(tmp);
      for (var j = 0;j < tmp.UnionPolicy.length;j++) {
        tmpUnionPolicy.push(tmp.UnionPolicy[j]);
      }        
    }
    $scope.current.PAM.Table1.UnionPolicy = _.uniqWith(tmpUnionPolicy, _.isEqual);
    console.log('UnionPolicy $scope.current.PAM.Table1');
    console.log($scope.current.PAM.Table1);
  };
    
  //Function to get Implementation Status and Period from individual PAMs
  $scope.Group.getImplementation = function(tempGroup) {      
    $scope.current.PAM.Table1.Implementation = [];
    var tempGroup = $scope.current.PAM.Table1.PolicyGroup;
    var tmpImplementation = [];
    var tmpObject = {};
    for (var i=0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      if (angular.isDefined(tmp.Implementation)) {     
        tmpObject = angular.copy(tmp.Implementation[0]);
        tmpObject.id = tempGroup[i];
        if (!$scope.isNullEmpty(tmpObject.Status)) {
          tmpImplementation.push(tmpObject);   
        }
      }
    }
    $scope.current.PAM.Table1.Implementation = tmpImplementation;

  };
    
  //Function to get Policy Impacting for individual PAMs
  $scope.Group.getPolicyImpact = function() {
    var tempGroup = $scope.current.PAM.Table1.PolicyGroup;
    var tmpPolicyImpact = [];
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table2;
      if (angular.isDefined(tmp.PolicyImpact)) {
        for (var j = 0; j < tmp.PolicyImpact.length;j++) {            
          if (tmpPolicyImpact.indexOf(tmp.PolicyImpact[j]) === -1 && !$scope.isNullEmpty(tmp.PolicyImpact[j])) {
            tmpPolicyImpact.push(tmp.PolicyImpact[j]);
          }
        }
      }        
    }      
    //$scope.current.PAM.Table2.PolicyImpact = tmpPolicyImpact;
  };
    
  //Function to get Entities from individual PAMs
  $scope.Group.getEntities = function() {      
    var tempGroup = $scope.current.PAM.Table1.PolicyGroup;
    var tmpEntities = [];
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      if (angular.isDefined(tmp.Entities)) {
        for (var j=0; j < tmp.Entities.length;j++) {            
          if (tmpEntities.indexOf(tmp.Entities[j]) === -1 && !$scope.isNullEmpty(tmp.Entities[j].Type) && !$scope.isNullEmpty(tmp.Entities[j].Name)) {
            tmpEntities.push(tmp.Entities[j]);
          }           
        }          
      }        
    }
    if (!tmpEntities.length) { tmpEntities.push(emptyPam.Table1.Entities[0]); }
    $scope.current.PAM.Table1.Entities = tmpEntities;      
  };
    
  //Function to get Projections Scenarios from individual PAMs
  $scope.Group.getScenarios = function() {      
    $scope.current.PAM.Table1.ProjectionsScenario = [];
    var tempGroup = $scope.current.PAM.Table1.PolicyGroup;
    var tmpScenario = [];
    var tmpObject = {};
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      if (tmp.ProjectionsScenario[0].Type) {     
        tmpObject = angular.copy(tmp.ProjectionsScenario[0]);
        tmpObject.id = tempGroup[i];
        tmpScenario.push(tmpObject);            
      }
    }
    $scope.current.PAM.Table1.ProjectionsScenario = tmpScenario;
  
  };

  //Handle different format of union policies list for sectorsFind
//  $scope.sectorsFindPolicies = function(item) {      
//    return $scope.sectorsFind(item.group + item.value);
//  }
    
  //Function for GroupBy feature of Select-UI
  //Energy_Generic is for grouping energy related union policies into one group for simplicity
/*  $scope.sectorsFind = function(item) {      
    var inverseSectorsMap = {
      "ES":"Energy_Supply",
      "EC":"Energy_Consumption",
      "TR":"Transport",
      "IP":"Industrial_Processes",
      "AG": "Agriculture", 
      "LULUCF":"LULUCF", 
      "WA":"Waste",
      "CC":"Cross-cutting",
      "OT": "Other"
    };
    var expression = /^[A-Z]+\_/;
    var res = item.match(expression);
    var result = undefined;
    result = $translate.instant("Labels.Table1.Sectors.list." + inverseSectorsMap[res[0].slice(0,-1)]);
    return result;
  };*/
    
  //Function for Group Objectives to return sector of individual objective
  /*$scope.Group.shortSectorsFind = function(item) {
    if (!item) { return "empty"; }
    var inverseSectorsMap = {
      "ES":"Energy_Supply",
      "EC":"Energy_Consumption",
      "TR":"Transport",
      "IP":"Industrial_Processes",
      "AG": "Agriculture", 
      "LULUCF":"LULUCF", 
      "WA":"Waste",
      "CC":"Cross-cutting",
      "OT": "Other"
    };

    var expression = /^[A-Z]+\_/;
    var res = item.match(expression);
    var result = undefined;
    result = $translate.instant("Labels.Table1.Sectors.shortlist." + inverseSectorsMap[res[0].slice(0,-1)]);                  
    return result;
  };       */         
    
  /**
   * Checks if PAM is active
   * @param {Number} index
   * @returns {Boolean} true if PAM is active
   */
  $scope.isCurrentPam = function(id) { 
    if (id === $scope.current.PAM.internalId) {
      return true;
    }
  };
    
  //Helper function to simulate loop functionality
  $scope.getNumber = function(number) {
    return new Array(number);
  };

  $scope.getNumberedArray = function(start,finish) {
    var tmpArray = [];
    for (var i = start; i < finish;i++)
    {
      tmpArray.push(i);
    }
    return tmpArray;
  };
  
  //Get the next available PaM Id
  $scope.getNextId = function() {
    var maxId = Math.max.apply(Math,$scope.instance.NEC_PAMs.NEC_PAM.map(function(o){return o.id;})) + 1;
    if (!maxId || !isFinite(maxId)) {
      return 1;
    }
    else {
      return maxId;
    }
  };
      
  // Function to add a new Single PAM
  $scope.addSingle = function(goEdit) {
    if (!$scope.instance) { return; }
    
    var clonedEmptyPaM = angular.copy(emptyPam);
    clonedEmptyPaM.id = $scope.getNextId();
    $scope.setRadioButtons(clonedEmptyPaM);

    $scope.instance.NEC_PAMs.NEC_PAM.push(clonedEmptyPaM);

    $timeout(function() {                      
      $scope.OverviewValidate();
      if (goEdit === true) {
        $scope.editTable(clonedEmptyPaM.internalId,1);
      }        
    },0);

  };

  // Function to add a new Group
  $scope.addGroup = function(goEdit) {
    if (!$scope.instance) { return; }
    var clonedEmptyPaM = angular.copy(emptyPam);
    clonedEmptyPaM.id = $scope.getNextId();
    clonedEmptyPaM.Table1.isGroup = 'group';
    $scope.instance.NEC_PAMs.NEC_PAM.push(clonedEmptyPaM);

    $timeout(function() {
      $scope.OverviewValidate();
      if (goEdit === true) {
        $scope.editTable(clonedEmptyPaM.internalId,1);
      }        
    },0);
  };

  // Function to get year ::ToBeEdited::
  $scope.getFutureYear = function(multi) {      
    var tmpYear = $scope.current.reportingYear;
    return ( 5 - ( tmpYear % 5 ) + tmpYear + 5 * multi ) ;
   };
   
  //Get index in array for a PAM internalId
  $scope.getIndexForInternalId = function(internalId) { 
    if (!$scope.instance.NEC_PAMs.NEC_PAM) { return; }
    for (var i=0;i<$scope.instance.NEC_PAMs.NEC_PAM.length;i++) {          
      if ($scope.instance.NEC_PAMs.NEC_PAM[i].internalId === internalId) {
        return i;
      }
    }
    return -1;
  };

    //Get index in array for a PAM id
    $scope.getIndexForId = function(id) { 
      if (!$scope.instance.NEC_PAMs.NEC_PAM) { return; }
      for (var i=0;i<$scope.instance.NEC_PAMs.NEC_PAM.length;i++) {          
        if ($scope.instance.NEC_PAMs.NEC_PAM[i].id === id) {
          return i;
        }
      }
      return -1;
    };
    
  /**
   * Deletes a selected PAM, also removing it from other group PaMs
   * @param {Number} index
   *
   */
  $scope.deletePAM = function(internalId) {
    if (confirm('Are you sure you want to delete this PAM')) {
      $scope.temp.disableWatchers = true;
      $scope.temp.Validation['ID' + internalId] = undefined;

      $scope.instance.NEC_PAMs.NEC_PAM.splice($scope.getIndexForInternalId(internalId),1);

      for (var i=0;i<$scope.instance.NEC_PAMs.NEC_PAM.length;i++) {
        var idx = $scope.instance.NEC_PAMs.NEC_PAM[i].Table1.PolicyGroup.indexOf(internalId);
        if (idx >= 0) {
          $scope.instance.NEC_PAMs.NEC_PAM[i].Table1.PolicyGroup.splice(idx, 1);
        }
      }
      $scope.temp.disableWatchers = false;
      $timeout(function() { $scope.goOverview(); }, 100);
    } 
  };
  
  $scope.getGroupList = function(single) {    
    if (single) { var mode = 'single'; }
    else var mode = 'group'; 
    var tmps = $scope.instance.NEC_PAMs.NEC_PAM;
    var tmp = [];
    for (var i = 0; i < tmps.length;i++) {
      if (tmps[i].Table1.isGroup === mode) {
        tmp.push(tmps[i]);
      }        
    }
    return tmp; 
    };
    /**
     * Checks if Table1 is empty for disabling tabs 2 and 3
     * @returns {Boolean} true if empty false if not
     */
    $scope.isDisabledTable1 = function() {
      if ($scope.isNullEmpty($scope.current.PAM.Title)) return true;
      return false;
    };

    /**
     * Calculates all table columns for Overview Table
     *
     */
    $scope.OverviewCalculate = function() {
      $scope.Overview.Table = {};
      $scope.Overview.Table.empty1 = [];
      $scope.Overview.Table.empty2 = [];
      $scope.Overview.Table.empty3 = [];
      $scope.Overview.Table.text1 = [];
      //$scope.Overview.Table.text2 = [];
      //$scope.Overview.Table.text3 = [];
      for (var i = 0; i < $scope.instance.NEC_PAMs.NEC_PAM.length;i++) {
        $scope.Overview.Table.empty1[i] = $scope.isEmpty(i,1);
        $scope.Overview.Table.empty2[i] = $scope.isEmpty(i,2);
        $scope.Overview.Table.empty3[i] = $scope.isEmpty(i,3);
        $scope.Overview.Table.text1[i] = $scope.Overview.Table.empty1[i] === true ? 'Labels.Overview.new_table' : 'Labels.Overview.edit_table';
        //$scope.Overview.Table.text2[i] = $scope.Overview.Table.empty2[i] === true ? 'Labels.Overview.new_table' : 'Labels.Overview.edit_table';
        //$scope.Overview.Table.text3[i] = $scope.Overview.Table.empty3[i] === true ? 'Labels.Overview.new_table' : 'Labels.Overview.edit_table';                                                               
      }
    };

    /**
     * Validates all fields for Overview Table and Save functionality
     *
     */
    $scope.OverviewValidate = function() {
      $scope.temp.Validation = {};      
      var tmp = $scope.instance.NEC_PAMs.NEC_PAM;
      for (var i = 0; i < tmp.length;i++) { 
        var valid = true;
        var PAM = tmp[i];
        //Table1 Validation
        if ($scope.isNullEmpty(PAM.Title) || $scope.isNullEmpty(PAM.Table1.Description) || $scope.isNull(PAM.Table1.isGroup)
                || $scope.isNullEmpty(PAM.Table1.Sectors) || $scope.isNullEmpty(PAM.Table1.Pollutants) || $scope.isNullEmpty(PAM.Table1.Objective)
                || $scope.isNullEmpty(PAM.Table1.PolicyInstrument) || $scope.isNullEmpty(PAM.Table1.Implementation[0].Status)
                || $scope.isNullNumber(PAM.Table1.Implementation[0].Start) || $scope.isNullEmpty(PAM.Table1.ProjectionsScenario[0].Type)
                ) valid = false;   
        //Table1 Other Union Policies Validation
        if (PAM.Table1.UnionPolicyRelated === 'yes'){
          if ($scope.isNullEmpty(PAM.Table1.UnionPolicy)) valid = false;
          //else if (PAM.Table1.UnionPolicy.indexOf('Other_EU') !== -1) {
           //for (var j = 0; j < PAM.Table1.UnionPolicyOther; i++) {
           //  if ($scope.isNullEmpty(PAM.Table1.UnionPolicyOther[j].Name)) valid = false;
           //}
          //}
        }        
        //Table1 Array Object Validation 
        for (var j = 0 ;j < PAM.Table1.Entities.length;j++) {
          if ($scope.isNull(PAM.Table1.Entities[j].Type) || $scope.isNull(PAM.Table1.Entities[j].Name)) valid = false;
        }
        //Table1 Group Validation
        if (PAM.Table1.isGroup === 'group') {
          if ($scope.isNullEmpty(PAM.Table1.PolicyGroup)) valid = false;
        }
        $scope.temp.Validation['ID' + PAM.internalId] = {};
        $scope.temp.Validation['ID' + PAM.internalId]['Table1'] = valid;
        //Table2 Validation
        //$scope.temp.Validation['ID' + PAM.internalId]['Table2'] = true;        
        //Table3 Validation
        //$scope.temp.Validation['ID' + PAM.internalId]['Table3'] = true;
      }      
    };

    $scope.isNull = function(obj) {
      if (!obj) return true;
      return false;
    };

    $scope.isNullEmpty = function(obj) {
      if (!obj || obj.length === 0) {
        return true;
      }
      return false;
    };
    /**
     * Checks if object is null or not a number
     * @param {type} obj
     * @returns {Boolean} true if object is null or not a number
     */
    $scope.isNullNumber = function(obj) {
      if (!obj || !angular.isNumber(obj)) {
        return true;
      }
      return false;
    };
    /**
     * Checks if all PAMs have no validation errors
     * @returns {Boolean} true if there are no validation errors
     * 
     */
    $scope.isValid = function() {
     $scope.OverviewValidate();
     var tmp = Object.keys($scope.temp.Validation);
     var isValid = true;
     for (var i = 0; i < tmp.length;i++) {
        console.log('$scope.temp.Validation[tmp[i]]');
        console.log($scope.temp.Validation[tmp[i]]);
        if (!$scope.temp.Validation[tmp[i]]['Table1']) {
          isValid = false;
          break;
        }     
        //if (!$scope.temp.Validation[tmp[i]]['Table2']) { 
        //  isValid = false;
        //  break;
        //}
        //if (!$scope.temp.Validation[tmp[i]]['Table3']) { 
        //  isValid = false;
        //  break;
        //}    
     }
     return isValid;
    };

    //if current PAM is a group return true
    $scope.isGroup = function() { 
      if ($scope.current.PAM.Table1.isGroup === 'group') {
        return true;
      }
    };
    
    // WEBQ Specific Functions
    //                   
    // save instance data.
    $scope.saveInstance = function(){
      console.log('in save instance!');
      $scope.temp.SaveDisabled = true;
      $scope.temp.disableWatchers = true;
      //$scope.Group.calculateAll();
      $scope.setCurrentPam($scope.current.PAM.internalId);
      $scope.temp.isGroup = ($scope.current.PAM.Table1.isGroup === 'group');
      $scope.Webform.$setPristine(true);
      var tmpScope = angular.copy($scope.instance);
      
      for (var i = 0, len = tmpScope.NEC_PAMs.NEC_PAM.length; i < len; i++) {
        console.log('tmpScope.NEC_PAMs.NEC_PAM[i].internalId');
        console.log(tmpScope.NEC_PAMs.NEC_PAM[i].internalId);
        //drop internal id's as they are only to be used in the webform and don't belong in the xml output.
        delete tmpScope.NEC_PAMs.NEC_PAM[i].internalId;
        //clear policies if not related
        if (tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicyRelated === "no") {
          tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicy = [];
          //tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicyOther = [];
          //tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicyOther.push(emptyPam.Table1.UnionPolicyOther[0]);
        }
        //Clear any other policies if 'Other' is not selected in the main list
        //if (tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicy.indexOf("Other_EU") === -1) {
          //tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicyOther = [];
          //tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicyOther.push(emptyPam.Table1.UnionPolicyOther[0]);
        //}
      }
      //Sort the PaMs before saving, so they are properly ordered in the xml-file for viewing in print-preview etc. 
      tmpScope.NEC_PAMs.NEC_PAM = $filter('orderBy')(tmpScope.NEC_PAMs.NEC_PAM, 'id');
      console.log('saveinstance tmpScope');
      console.log(tmpScope);
      dataRepository.saveInstance(tmpScope)
        .error(function() {
          alert("Error! Data is not saved! Please try again");
          $scope.Webform.$setPristine(false);
          $scope.temp.SaveDisabled = false;
          $scope.temp.disableWatchers = false;
        })
        .success(function(data,status){
            console.log('in success');
            console.log(data);
            console.log(status);
            $scope.temp.SaveDisabled = false;
            $scope.temp.disableWatchers = false;
            console.log('data.code');
            console.log(data.code);
            if (data.code === 1) {
            //Validation functionality
              //Always validate on Save
              //if ($scope.ValidationEnabled) {
                $scope.OverviewValidate();
                $scope.temp.isValid = false;              
                if ($scope.isValid()) $scope.temp.isValid = true;
                if (!$scope.temp.isValid) { alert("Data Saved, but Webform contains validation errors"); }
                else alert(data.message);
              //}
              //else alert(data.message);
              $scope.Webform.$setSubmitted(true);
            }                    
            else alert("Error1! Data is not saved! Please try again");            
        });
    };

    /**
     * Close webform and return to webq application
     *
     */
    $scope.close = function(){
      if ($scope.Webform.$submitted || $scope.Webform.$pristine || confirm("Continue and lose unsaved changes?")) { 
        var url = dataRepository.getCloseUrl();
        $window.location = url;
      }
    };
    
    // Function to get HTML conversion id for preview purposes
    $scope.current.fileInfo = null;
    dataRepository.getFileInfo().success(function(xml) {      
      $scope.current.fileInfo = xml;            
    });
    
    $scope.getConversionNumber = function() {
      var conversionNumber = null;       
      if (!$scope.current.fileInfo.conversions) { return; }
      var tempConversions = $scope.current.fileInfo.conversions;        
      for (var i = 0;i < tempConversions.length;i++) {
        if (tempConversions[i].resultType === 'HTML') {
          conversionNumber = tempConversions[i].id;
        }
      }       
      return conversionNumber;
    };

    // convert XML to HTML in new window.
    $scope.printPreview = function(){         
      var conversionNumber = $scope.getConversionNumber();
      if (!conversionNumber || conversionNumber === null) return;
      var conversionLink = dataRepository.getPrintPreviewUrl(conversionNumber);
      var win = $window.open(conversionLink, '_blank');
      win.focus;             
    };     
    
    //Controller Functions
    //$scope.model = require('./model.json');
    
    var emptyPam = require('./emptyPam.json');
    
    var emptyTables = {
      emptyTable1: emptyPam.Table1//,
      //emptyTable2: emptyPam.Table2,
      //emptyTable3: emptyPam.Table3
    };       
    // disable function for select fields 
    $scope.searchEnabled = false;
        
    //temp scope variables
    $scope.temp.overview = [{}];
    //$scope.temp.ObjectiveOtherSector = null;
    //$scope.temp.ObjectiveOtherText = null;
    $scope.temp.overview[0].empty = false;
    $scope.temp.PolicyGroup = [];            
    $scope.temp.Entity = {};
    $scope.temp.Entity.name = null;
    $scope.temp.Entity.type = null;
    $scope.temp.Validation = {};
    
    //Scope variable for current year
    var date = new Date();
    $scope.current.reportingYear = date.getFullYear();    
    
    $scope.current.webqUrl = dataRepository.getCloseUrl();
    $scope.addSingle(false);
    $scope.setCurrentPam(1);
        
    // Watch empty instance
    $scope.$watch('emptyInstance', function(newValue, oldValue) {
      if (!angular.isDefined(newValue)) { return; }
      if (!angular.isDefined(newValue.NEC_PAMs)) { return; }              
    });
    
    $scope.Table1ClearUnionPolicy = function() {
      $timeout(function() { $scope.current.PAM.Table1.UnionPolicy = []; },0);
    };


    // Clear list of other union policies when "Other (Union policy not listed above or additional Union policy)" is not selected 
    /*$scope.UpdateOtherPolicies = function() {
      if ($scope.current.PAM.Table1.UnionPolicy.indexOf("Other_EU") === -1 && $scope.current.PAM.Table1.UnionPolicyOther.length > 0 && $scope.current.PAM.Table1.UnionPolicyOther[0].Name != null) {
        $scope.current.PAM.Table1.UnionPolicyOther.length = 0; //Clear array
        $scope.addItem('Table1.UnionPolicyOther');
      }
    };*/
   
    // Model manipulation watchers for single or group
    $scope.$watch('current.PAM.Table1.isGroup', function(newValue, oldValue) {      
      if ($scope.temp.disableWatchers) { return; }
      if (newValue === 'single') {        
        $scope.current.PAM.Table1.PolicyGroup = [];
        $scope.temp.isGroup = false;        
      }
      else if (newValue === 'group') {        
        $scope.temp.isGroup = true;
        $scope.Group.calculateGroup();        
      }
    }); 
    
    $scope.$watchCollection('current.PAM.Table1.PolicyGroup', function(newValue,oldValue) {
      if ($scope.temp.disableWatchers) { return; }
      if ($scope.temp.SaveDisabled) { return; }
      if (!$scope.isNullEmpty(newValue)) {
        $scope.Group.calculateGroup();
      }
    });

    //ng-show="current.PAM.Table1.Agriculture[0].
    //Function to calculate group values and change instance file
    $scope.Group.calculateGroup = function() {  
      if ($scope.current.PAM.Table1.isGroup !== 'group') { return; }
      $scope.Group.getSectors($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getPollutants($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getObjectives($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getPolicyInstrument($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getUnionPolicies($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getImplementation($scope.current.PAM.Table1.PolicyGroup);
      //$scope.Group.getEnvisaged();
      //$scope.Group.getPolicyImpact();
      $scope.Group.getEntities($scope.current.PAM.Table1.PolicyGroup);
      $scope.Group.getScenarios($scope.current.PAM.Table1.PolicyGroup);
    };
    
    //Function to run Group Calculations for every PAM in Webform
    $scope.Group.calculateAll = function() {      
      var currentPam = $scope.current.PAM;
      for (var i = 0;i < $scope.instance.NEC_PAMs.NEC_PAM.length;i++) {                         
          $scope.current.PAM = $scope.instance.NEC_PAMs.NEC_PAM[i];
          if ($scope.current.PAM.Table1.isGroup === 'group') {
            $scope.temp.isGroup = true;
            $scope.Group.calculateGroup();
          }
          else $scope.temp.isGroup = false;
      }
      $scope.current.PAM = currentPam;
    };
      
    // Watch Collection to recreate ID's on PAM add or removal
    $scope.$watchCollection('instance.NEC_PAMs.NEC_PAM', function(newPAMs,oldPAMs) {
      if (newPAMs.length > oldPAMs.length) {
        for (var i = 0; i < newPAMs.length;i++) {
          if (!angular.isDefined($scope.Overview.Table.empty1[i])) {
            $scope.Overview.Table.empty1[i] = true;
            $scope.Overview.Table.empty2[i] = true;
            $scope.Overview.Table.empty3[i] = true;
            $scope.Overview.Table.text1[i] = 'Labels.Overview.new_table';
            //$scope.Overview.Table.text2[i] = 'Labels.Overview.new_table';
            //$scope.Overview.Table.text3[i] = 'Labels.Overview.new_table';          
          }
        }
      }
      for (var i = 0; i < newPAMs.length;i++) {        
        $scope.instance.NEC_PAMs.NEC_PAM[i].internalId = i+1;
        // set default PaM ID
        if (!$scope.instance.NEC_PAMs.NEC_PAM[i].id) {
          $scope.instance.NEC_PAMs.NEC_PAM[i].id = i+1;
        }
      }
    });

    /*$scope.$watchCollection('current.PAM.Table1.Sectors', function(newValue,oldValue) {         
      if (newValue.length === 0) {
        $scope.current.PAM.Table1.Objective = [];
      }
    });*/    
}]);

webform.config(['$locationProvider', '$translateProvider', 'uiSelectConfig', 'languageChangerProvider', 'usSpinnerConfigProvider', function($locationProvider, $translateProvider, uiSelectConfig, languageChangerProvider,usSpinnerConfigProvider) {

  uiSelectConfig.theme = 'select2';
  uiSelectConfig.resetSearchInput = true;
 
  languageChangerProvider.setDefaultLanguage('en');
  languageChangerProvider.setLanguageFilePrefix('mmr-pams-labels-');

  var availableLanguages = require('./availableLanguages.json');  
  languageChangerProvider.setAvailableLanguages(availableLanguages);
          
  $locationProvider.hashPrefix('!');  
  usSpinnerConfigProvider.setDefaults({
    lines: 9, // The number of lines to draw
     length: 0, // The length of each line
     width: 20, // The line thickness
     radius: 34, // The radius of the inner circle
     corners: 0.3, // Corner roundness (0..1)
     rotate: 17, // The rotation offset
     direction: 1, // 1: clockwise, -1: counterclockwise
     color: 'white', // #rgb or #rrggbb or array of colors
     speed: 1.3, // Rounds per second
     trail: 79, // Afterglow percentage
     shadow: false, // Whether to render a shadow
     hwaccel: true, // Whether to use hardware acceleration
     className: 'spinner', // The CSS class to assign to the spinner
     zIndex: 2e9, // The z-index (defaults to 2000000000)
     top: '50%', // Top position relative to parent
     left: '50%' // Left position relative to parent
  });
}]);

webform.run(['dataRepository', '$q', '$rootScope', 'promiseTracker', function(dataRepository, $q, $rootScope, promiseTracker, $location) {
  
  $rootScope.loadingTracker = promiseTracker({ activationDelay: 500, minDuration: 750 });
  
}]);

// get instance data and save instance data
webform.factory('dataRepository', ['$rootScope', '$http', '$location', 'promiseTracker', '$window', function($rootScope, $http, $location, promiseTracker,$window) {
  // Function is used before saving JSON object back to XML file. When deleting field on the form
  // angular sets it to undefined which breaks the order of elements if converted to XML.
  var fixUndefined = function(obj) {
    var isArray = obj instanceof Array;
    for (var j in obj) {
      if (obj.hasOwnProperty(j)) {
        if (typeof(obj[j]) === "object") {
          fixUndefined(obj[j]);
        } else if(!isArray && j !== '$$hashkey') {
          if (typeof obj[j] === 'undefined') {
            obj[j] = null;
          }
        }
      }
    }
    if (isArray && obj.length === 0) {
      obj[0] = null;
    }
  };           
  // Function to get parameters from absolute url
  var getParameterByName = function(name) {
      var searchArr = $window.location.search.split('?');
      var search = '?' + searchArr[searchArr.length - 1];
      var match = new RegExp('[?&]' + name + '=([^&]*)').exec(search);
      return match && decodeURIComponent(match[1].replace(/\+/g, ' '));
  };
  
  // Internet Explorer Fix - http://tosbourn.com/a-fix-for-window-location-origin-in-internet-explorer/
  if (!$window.location.origin) {
    $window.location.origin = $window.location.protocol + "//" + $window.location.hostname + ($window.location.port ? ':' + $window.location.port: '');
  }
  
  var serverPath = $window.location.origin;
  var formPath = $window.location.pathname;
  formPath = formPath.substring(0, formPath.lastIndexOf("/") + 1);
  var formUrl = serverPath + formPath;    
  var fileId = getParameterByName("fileId");
  var envelope = getParameterByName("envelope");
  var baseUri = getParameterByName("base_uri");  
  if (!baseUri) baseUri = '';
  var host = serverPath + baseUri;
  var sessionId = getParameterByName("sessionid");
  var loadingTracker = promiseTracker();
  
  var codeLists = {};
  var getWebQUrl = function(path) {
    var url = host;    
    url += path;
    url += "?fileId=" + fileId;              
    if (sessionId && sessionId !== null) {
        url += "&sessionid=" + sessionId;
    }
    return url;
  };

  return {
      getEmptyInstance: function() {              
        var url = null;
        if (fileId){ // i.e. running in WebQ
          url = "instance-empty.xml";
        } else {
          // testing on localhost
          url = "instance-empty.json";
        }
        return $http.get(url, {params: { format: "json" }}, {tracker : $rootScope.loadingTracker});
      },
      getInstance: function() {
          var url = null;
          if (fileId){
              url = getWebQUrl("/download/converted_user_file");                        
          } else{
              // testing on localhost
              url = "instance-empty.json";
          }          
          return $http.get(url, {tracker : $rootScope.loadingTracker});
      },
      saveInstance: function (data) {
          var url = getWebQUrl("/saveXml");
          fixUndefined(data);          
          return $http.post(url, data, {tracker : $rootScope.loadingTracker});
      },
      getCloseUrl: function() {
        //change function for localhost?
        //var url = serverPath;
        //url += (envelope) ? envelope : baseUri;   
        if (baseUri === '') baseUri = "/";
        url = (envelope) ? envelope : baseUri;
        return url;
      },
      getPrintPreviewUrl: function(conversionNumber) {        
        var url = host;
        url += "/download/convert";        
        url += "?fileId=" + fileId;
        if (sessionId && sessionId !== null) {
          url += "&sessionid=" + sessionId;
        } 
        url += "&conversionId=" + conversionNumber;                
        return url;
      },
      getCodeList: function() {
          return codeLists;
      },
      loadCodeList: function(language) {
          //finds file in project folder
          var defaultlanguage = 'en';
          var currentLanguage = !language? defaultlanguage : language;

          //var url = "mmr-pams-codelists-" + currentLanguage + ".json";

          //return $http.get(url, {tracker : $rootScope.loadingTracker});
          //$http.get(url, {tracker : loadingTracker}).success(function(newCodeList) {
          //    angular.copy(newCodeList, codeLists);
          //});
      },
      getFileInfo: function() {
        if (!fileId) { 
          url = "file-info.json"; 
        }
        else {
          var url = host;      
          url += "/file/info";
          url += "?fileId=" + fileId;
        }
        return $http.get(url, {tracker : $rootScope.loadingTracker});
      },
      fetchTranslations: function(countryCode) {
        var url = getWebQUrl("");
        return $http.get();                  
      }                
  };
}]);


// Directives
//====================================================================

// Unique PaM ID validation
webform.directive('uniqueId', function() {
  return {
    require: 'ngModel',
    link: function (scope, element, attrs, ctrl) {
      ctrl.$parsers.unshift(function (viewValue) {
        if (!isNaN(parseFloat(viewValue)) && isFinite(viewValue)) {
          var controllerScope = angular.element(document.body).scope();
          for (var i=0;i<controllerScope.instance.NEC_PAMs.NEC_PAM.length;i++) {
            if (controllerScope.instance.NEC_PAMs.NEC_PAM[i].id == viewValue) {
              //ID already exists, return invalid
              ctrl.$setValidity('uniqueId', false);
              // when invalid we could also return undefined (no model update happens), but it's less practical here
              return viewValue;
            }
          }
          ctrl.$setValidity('uniqueId', true);
          return viewValue;
        } 
      });
    }
  };  
});

// Compare with other value if equal or greater
webform.directive('greaterEqualThan', function() {
  return {
    require: 'ngModel',
    link: function (scope, element, attrs, ctrl) {
      var validate = function(viewValue) {
        var comparisonValue = attrs.greaterEqualThan;
        //Skip if we don't have values to check
        if (isNaN(parseFloat(viewValue)) || !isFinite(viewValue) || isNaN(parseFloat(comparisonValue)) || !isFinite(comparisonValue)) {
          return viewValue;
        }
        //Valid if the value is equal or greater than the comparison value
        ctrl.$setValidity('greaterEqualThan', parseInt(viewValue, 10) >= parseInt(comparisonValue, 10));
        return viewValue;
      };
      ctrl.$parsers.unshift(validate);
      ctrl.$formatters.push(validate);
      // re-validate on update
      attrs.$observe('greaterEqualThan', function(comparisonValue){
        return validate(ctrl.$viewValue);
      });
    }
  }
});

// If implementation status planned, start year should be in the future
webform.directive('matchesPlannedStatus', function() {
  return {
    require: 'ngModel',
    link: function (scope, element, attrs, ctrl) {
      var validate = function(viewValue) {
        var implStatus = attrs.matchesPlannedStatus; //implementation status
        var dateField = attrs.name; //start or end date input field
        var currentYear = new Date().getFullYear(); //current year for comparison
        if (new Date().getMonth() > 7) {
          currentYear += 1; //assume preparing for reporting early the following year. 
        }

        //Skip if we don't have values to check
        if (isNaN(parseFloat(viewValue)) || !isFinite(viewValue) || !implStatus || !dateField) {
          return viewValue;
        }
        var dateValue = parseInt(viewValue, 10);
        
        //Start year must be current year or in the future when 'planned' or 'adopted'
        if (dateField == "table1_ImplementationPeriodStart" && dateValue < currentYear && (implStatus == "Planned" || implStatus == "Adopted")) {
          ctrl.$setValidity('matchesPlannedStatus', false); //set 'invalid'
          return viewValue;
        }
        //Start year must be current year or in the past when 'expired'/'implemented'
        if (dateField == "table1_ImplementationPeriodStart" && dateValue > currentYear && (implStatus == "Expired" || implStatus == "Implemented")) {
          ctrl.$setValidity('matchesPlannedStatus', false); //set 'invalid'
          return viewValue;
        }
        //Finish year must be current year or in the past when 'expired'
        if (dateField == "table1_ImplementationPeriodFinish" && dateValue > currentYear && implStatus == "Expired") {
          ctrl.$setValidity('matchesPlannedStatus', false); //set 'invalid'
          return viewValue;
        }
        //Finish year must be current year or in the future when 'Adopted'/'Implemented'/'Planned'
        if (dateField == "table1_ImplementationPeriodFinish" && dateValue < currentYear && (implStatus == "Adopted" || implStatus == "Implemented" || implStatus == "Planned")) {
          ctrl.$setValidity('matchesPlannedStatus', false); //set 'invalid'
          return viewValue;
        }
        
        //Default to 'valid'
        ctrl.$setValidity('matchesPlannedStatus', true);
        return viewValue;
        
      };
      ctrl.$parsers.unshift(validate);
      ctrl.$formatters.push(validate);
      // re-validate on update
      attrs.$observe('matchesPlannedStatus', function(comparisonValue){
        return validate(ctrl.$viewValue);
      });
    }
  }
});
