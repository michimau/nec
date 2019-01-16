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
    $scope.mandatoryPollutant = 0;

    $scope.treeData.sectorsData = require('./treeData/sectorsData.json');
    $scope.treeData.unionPolicyData = require('./treeData/unionPolicyData.json');
    $scope.treeData.pollutantsData = require('./treeData/pollutantsData.json');
    $scope.treeData.entitiesData = require('./treeData/entitiesData.json');
    $scope.treeData.policyInstrumentsData = require('./treeData/policyInstrumentsData.json');
    $scope.treeData.implementationStatusData = require('./treeData/implementationStatusData.json');
    $scope.treeData.projectionsScenarioData = require('./treeData/projectionsScenarioData.json');
    $scope.treeData.ammoniaEmissionsControlPracticesData = require('./treeData/ammoniaEmissionsControlPracticesData.json');
    $scope.treeData.inorganicFertilisersData = require('./treeData/inorganicFertilisersData.json');
    $scope.treeData.ammoniaEmissionsLivestockData = require('./treeData/ammoniaEmissionsLivestockData.json');
    $scope.treeData.nationalAdvisoryCodeData = require('./treeData/nationalAdvisoryCodeData.json');
    $scope.treeData.reportedAlreadyData = require('./treeData/reportedAlreadyData.json');

  /////////////////////////////////////////////////START RADIO BUTTONS CONTROL/////////////////////////////////////////////////

    $scope.emptyUnionPolicyTreeInstance = function(node, selected, event) {
      $scope.unionPolicyTreeInstance.jstree(true).uncheck_all();
    }

    $scope.hideAgricultureObjects = function() {
      $scope.current.PAM.Table1.T264[0].MeasuresAmmoniaControlQuestion = 'no';
      $scope.emptyMeasuresAmmoniaControlObjects();
      $scope.current.PAM.Table1.T264[0].FineParticulateMatterEmissionsQuestion = 'no';
      $scope.emptyFineParticulateMatterEmissionsObjects();
      $scope.current.PAM.Table1.T264[0].PreventingImpactsSmallFarmsQuestion = 'no';
      $scope.emptyPreventingImpactsSmallFarmsObjects();
    }

    $scope.hideMeasuresAmmoniaControlObjects = function() {
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].AmmoniumCarbonateFertilisersQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockQuestion = 'no';
      $scope.emptyAmmoniaEmissionsLivestockObjects();
    }
  
    $scope.emptyAmmoniaEmissionsControlPracticesObjects = function() {
      if($scope.ammoniaEmissionsControlPracticesTreeInstance) {$scope.ammoniaEmissionsControlPracticesTreeInstance.jstree(true).uncheck_all()};
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesPage = '';
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesExactly = 'yes';
      //$scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesExactlyReason = '';
      $scope.emptyAmmoniaEmissionsControlPracticesExactlyReason();

      $scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetPage = '';
      $scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetExactly = 'yes';
      //$scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetExactlyReason = '';
      $scope.emptyNationalNitrogenBudgetExactlyReason();

      if($scope.inorganicFertilisersTreeInstance) {$scope.inorganicFertilisersTreeInstance.jstree(true).uncheck_all()};
      $scope.current.PAM.Table1.T264[0].InorganicFertilizersPage = '';
      $scope.current.PAM.Table1.T264[0].InorganicFertilizersExactly = 'yes';
      $scope.emptyInorganicFertilizersExactlyReason()
      //$scope.current.PAM.Table1.T264[0].InorganicFertilizersExactlyReason = '';
    }
    
    $scope.emptyNationalNitrogenBudgetExactlyReason = function() {
      $scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetExactlyReason = '';
    }

    $scope.emptyInorganicFertilizersExactlyReason = function() {
      $scope.current.PAM.Table1.T264[0].InorganicFertilizersExactlyReason = '';
    }

    $scope.emptyAmmoniaEmissionsControlPracticesExactlyReason = function() {
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesExactlyReason = '';
    }

    $scope.emptyMeasuresAmmoniaControlObjects = function() {
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].NationalNitrogenBudgetQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].AmmoniumCarbonateFertilisersQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersQuestion = 'no';
      $scope.emptyAmmoniaEmissionsControlPracticesObjects();
      $scope.emptyAmmoniaEmissionsLivestockObjects();
      $scope.emptyInorganicFertilisersObjects();

      if ($scope.current.PAM.Table1.T264[0].FineParticulateMatterEmissionsQuestion == 'no') {
        $scope.current.PAM.Table1.T264[0].PreventingImpactsSmallFarmsQuestion = 'no';
        $scope.emptyPreventingImpactsSmallFarmsObjects();
      }
    }

    $scope.emptyFineParticulateMatterEmissionsObjects = function() {
      $scope.current.PAM.Table1.T264[0].OpenFieldBurningQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].NationalAdvisoryCodeQuestion = 'no';
      $scope.emptyNationalAdvisoryCodeObjects();
      $scope.emptyOpenFieldBurningObjects();

      if ($scope.current.PAM.Table1.T264[0].MeasuresAmmoniaControlQuestion == 'no') {
        $scope.current.PAM.Table1.T264[0].PreventingImpactsSmallFarmsQuestion = 'no';
        $scope.emptyPreventingImpactsSmallFarmsObjects();
      }
    }

    $scope.emptyOpenFieldBurningObjects = function() {
      $scope.current.PAM.Table1.T264[0].OpenFieldBurningBanEnforced = 'no';
      $scope.current.PAM.Table1.T264[0].OpenFieldBurningBanExemptions = 'no';
    }

    $scope.emptyNationalAdvisoryCodeObjects = function() {
      if ($scope.nationalAdvisoryCodeTreeInstance) {$scope.nationalAdvisoryCodeTreeInstance.jstree(true).uncheck_all()};
      $scope.current.PAM.Table1.T264[0].NationalAdvisoryCodeOther = '';
    }
    
    $scope.emptyPreventingImpactsSmallFarmsObjects = function() {
      $scope.current.PAM.Table1.T264[0].SmallMicroFarmsFullAccountQuestion = 'no';
      $scope.current.PAM.Table1.T264[0].SmallMicroFarmsExemptionsQuestion = 'no';
    }
 
    $scope.emptyInorganicFertilisersObjects = function () {
      if ($scope.inorganicFertilisersTreeInstance) {$scope.inorganicFertilisersTreeInstance.jstree(true).uncheck_all()};
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersOther = '';
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersPage = '';
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersExactly = 'yes';
      //$scope.current.PAM.Table1.T264[0].InorganicFertilisersExactlyReason = '';
      $scope.emptyInorganicFertilisersExactlyReason();
    }

    $scope.emptyInorganicFertilisersExactlyReason = function() {
      console.log('InorganicFertilisersExactlyReason!');
      $scope.current.PAM.Table1.T264[0].InorganicFertilisersExactlyReason = '';
    }

    $scope.emptyAmmoniaEmissionsLivestockObjects = function() {
      if ($scope.ammoniaEmissionsLivestockTreeInstance) {$scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).uncheck_all()};
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockOther = '';
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockPage = '';
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockExactly = 'yes';
      //$scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockExactlyReason = '';
      $scope.emptyAmmoniaEmissionsLivestockExactlyReason();
    }

    $scope.emptyAmmoniaEmissionsLivestockExactlyReason = function() {
      console.log('AmmoniaEmissionsLivestockExactlyReason!');
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestockExactlyReason = '';
    }

    $scope.setRadioButtons = function(pam) {
      console.log('pam in setRadioButtons');
      console.log(pam);
      if (!pam.Table1.T261.UnionPolicyRelated) { pam.Table1.T261.UnionPolicyRelated = "no" };
      pam.Table1.AgriculturalRelated = "no";
      pam.Table1.T264.NationalAdvisoryCode = "no";

      pam.Table1.T264.MeasuresControlAmmoniaEmissions = "no";

      pam.Table1.T264.AmmoniaEmissionsControlPracticesQuestion = "no";
      pam.Table1.T264.AmmoniaEmissionsControlPracticesExactly = "yes";

      //pam.Table1.T264.MeasuresControlAmmoniaEmissionsExactly = "yes";

      pam.Table1.T264.NationalNitrogenBudgetQuestion = "no";
      pam.Table1.T264.NationalNitrogenBudgetExactly = "yes";

      pam.Table1.T264.InorganicFertilisersQuestion = "yes";
      pam.Table1.T264.InorganicFertilizersExactly = "yes";

      pam.Table1.T264.AmmoniaEmissionsLivestockExactly = "yes"

      pam.Table1.T264.InorganicFertilisers = "no";

      pam.Table1.T264.FineParticulateMatterEmissions = "no";
      pam.Table1.T264.OpenFieldBurningExactly = "yes";
      pam.Table1.T264.NationalAdvisoryCodeExactly = "yes";

      pam.Table1.T264.PreventingImpactsSmallFarms = "no";
      pam.Table1.T264.ExemptSmallMicroFarmsPageExactly = "yes";

      pam.Table1.SelectedForAdoption = "no";

      pam.Table1.T261.QualitativeDescriptionUncertaintiesQuestion = "no";
    };

  /////////////////////////////////////////////////END RADIO BUTTONS CONTROL/////////////////////////////////////////////////

  /////////////////////////////////////////////////START TREE's STRUCTURES CONTROL/////////////////////////////////////////////////

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
      $scope.projectionsScenarioTreeInstance.jstree(true).hide_icons();
      $scope.ammoniaEmissionsControlPracticesTreeInstance.jstree(true).hide_icons();
      $scope.inorganicFertilisersTreeInstance.jstree(true).hide_icons();
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).hide_icons();
      $scope.nationalAdvisoryCodeTreeInstance.jstree(true).hide_icons();
      $scope.reportedAlreadyTreeInstance.jstree(true).hide_icons();
    }

    $scope.nodePollutantChanged = function(node, selected, event) {
      $scope.mandatoryPollutant = 0;
      var nodes = selected.selected;
      $scope.pollutantsTreeInstance.jstree(true).get_selected().forEach(function(node) {
        if ($scope.pollutantsTreeInstance.jstree(true).get_node(node).original.mandatory == 1 && $scope.mandatoryPollutant !==1) { 
          $scope.mandatoryPollutant = 1;
        }
      });

      var pollutant = {};
      nodes.forEach(function(node) {
        if ($scope.pollutantsTreeInstance.jstree(true).get_node(node).children.length == 0) {
          if ($scope.current.PAM.Table1.T261p.Pollutants.length == 0 || !(_.find($scope.current.PAM.Table1.T261p.Pollutants, function(o) { return o.Name === node; }))) {
            
            pollutant.Name = node;
            pollutant.Target2020 = null;
            pollutant.Target2025 = null;
            pollutant.Target2030 = null;
            pollutant.TargetUnit = 'kt/year';
            console.log('pushing ' + pollutant.Name);
            $scope.current.PAM.Table1.T261p.Pollutants.push(pollutant);
          }
        }
        pollutant = {};
      });

      //removing Pollutants not selected from object
      if ($scope.current.PAM.Table1.T261p.Pollutants) {
        $scope.current.PAM.Table1.T261p.Pollutants.forEach (function(pollutant) {
          if (!( _.find(nodes, function(o) { return o === pollutant.Name; }) )) {
            $scope.current.PAM.Table1.T261p.Pollutants = $scope.current.PAM.Table1.T261p.Pollutants.filter(function(el){
              return el.Name !== pollutant.Name;
            });
          }
        })
      }

      if (selected.node && selected.node.children.length > 0 && selected.selected.length > 0) {
        $scope.pollutantsTreeInstance.jstree(true).open_node(selected.node.id);  
      };
    }

    $scope.nodeSectorChanged = function(node, selected, event) {
        var nodes = selected.selected;
        var objective = {};
        nodes.forEach(function(node) {
          if ($scope.sectorsTreeInstance.jstree(true).get_node(node).children.length == 0) {
            if ($scope.current.PAM.Table1.T261[0].Objectives.length == 0 || !(_.find($scope.current.PAM.Table1.T261[0].Objectives, function(o) { return o.Objective === node; }))) {
              //objective.Sector = $scope.sectorsTreeInstance.jstree(true).get_parent(node);
              //objective.SectorDescription = $scope.sectorsTreeInstance.jstree(true).get_text($scope.sectorsTreeInstance.jstree(true).get_parent(node));
              objective.Objective = node;
              //objective.ObjectiveDescription = $scope.sectorsTreeInstance.jstree(true).get_text(node);
              if (node.includes("_other")) {
                objective.ObjectiveDescription = '';
              }
              $scope.current.PAM.Table1.T261[0].Objectives.push(objective);
            }
          }
          objective = {};
        });
        //removing Objectives not selected from object
        $scope.current.PAM.Table1.T261[0].Objectives.forEach (function(objective) {
          if (!( _.find(nodes, function(o) { return o === objective.Objective; }) )) {
            $scope.current.PAM.Table1.T261[0].Objectives = $scope.current.PAM.Table1.T261[0].Objectives.filter(function(el){
              return el.Objective !== objective.Objective;
            });
          }
        })

        if (selected.node && selected.node.children.length > 0 && selected.selected.length > 0) {
          $scope.sectorsTreeInstance.jstree(true).open_node(selected.node.id);  
        };

        console.log('$scope.current.PAM');
        console.log($scope.current.PAM);
    }

    $scope.nodePolicyInstrumentsChanged = function(node, selected, event) {
      $scope.current.PAM.Table1.T261[0].PolicyInstruments = selected.selected;
    }

    $scope.reportedAlreadyChanged = function(node, selected, event) {
      $scope.current.PAM.Table1.ReportedAlready = selected.selected;
    }

    $scope.nodeUnionPolicyChanged = function(node, selected, event) {
      var nodes = selected.selected;
      //var unionPolicyType = {};
      var unionPolicies = {};

      nodes.forEach(function(node) {
        if ($scope.unionPolicyTreeInstance.jstree(true).get_node(node).children.length == 0) {
          if ($scope.current.PAM.Table1.T261[0].UnionPolicies.length == 0 || !(  _.find($scope.current.PAM.Table1.T261[0].UnionPolicies, function(o) { return o.UnionPolicy === node; })  )) {
            unionPolicies.UnionPolicy = node;
            if (node.includes("_other")) {
              unionPolicies.UnionPolicyDescription = '';
            }
            $scope.current.PAM.Table1.T261[0].UnionPolicies.push(unionPolicies);
          }
        }
        unionPolicies = {};
      });

      //removing UnionPolicy not selected from object
      $scope.current.PAM.Table1.T261[0].UnionPolicies.forEach (function(UnionPolicies) {
        if (!( _.find(nodes, function(o) { return o === UnionPolicies.UnionPolicy; }) )) {
          $scope.current.PAM.Table1.T261[0].UnionPolicies = $scope.current.PAM.Table1.T261[0].UnionPolicies.filter(function(el){
            return el.UnionPolicy !== UnionPolicies.UnionPolicy;
          });
        }
      })      

      if (selected.node) {
        if (selected.node.children.length > 0 && selected.selected.length > 0) {
          $scope.unionPolicyTreeInstance.jstree(true).open_node(selected.node.id);  
        };
      };

      console.log('$scope.current.PAM');
      console.log($scope.current.PAM);
    }

    $scope.nodeProjectionsScenarioChanged = function(node, selected, event) {
      //$scope.current.PAM.Table1.T261[0].ProjectionsScenario.Type = selected.selected;
      $scope.current.PAM.Table1.T261[0].ProjectionsScenario = selected.selected;
    }

    $scope.nodeAmmoniaEmissionsControlPracticesChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPractices = selected.selected;
    }

    $scope.nodeInorganicFertilisersChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.T264[0].InorganicFertilisers = selected.selected;
    }

    $scope.nodeNationalAdvisoryCodeChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.T264[0].NationalAdvisoryCode = selected.selected;
    }

    $scope.nodeAmmoniaEmissionsLivestockChanged = function(node, selected, event) {
      console.log(selected.selected);
      $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestock = [];
      $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).get_selected().forEach(function(node) {
        if ( $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).is_leaf(node) === true) {
          $scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestock.push(node);
        }
      });
    }

    $scope.setCurrentTreeData = function() {

      $scope.mandatoryPollutant = 0;
      if ($scope.current.PAM.Table1.T261p.Pollutants && $scope.current.PAM.Table1.T261p.Pollutants.len !== 0) {
        $scope.pollutantsTreeInstance.jstree(true).deselect_all(true);
        $scope.pollutantsTreeInstance.jstree('close_all');
        if ($scope.current.PAM.Table1.T261p.Pollutants) {
        $scope.current.PAM.Table1.T261p.Pollutants.forEach (function(node) {
          $scope.pollutantsTreeInstance.jstree(true).select_node (node.Name , true, false);
          if (($scope.pollutantsTreeInstance.jstree(true).get_node(node.Name).original) && $scope.pollutantsTreeInstance.jstree(true).get_node(node.Name).original.mandatory == 1 && $scope.mandatoryPollutant !==1) { 
            $scope.mandatoryPollutant = 1;
          }
        })
      }
      //console.log('get_undetermined');
      //console.log($scope.pollutantsTreeInstance.jstree(true).get_undetermined(true));

      $scope.reportedAlreadyTreeInstance.jstree(true).deselect_all(true);
      $scope.reportedAlreadyTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.ReportedAlready , true, false);
      
      $scope.sectorsTreeInstance.jstree(true).deselect_all(true);
      $scope.sectorsTreeInstance.jstree('close_all');
      if ($scope.current.PAM.Table1.T261[0].Objectives) {
        $scope.current.PAM.Table1.T261[0].Objectives.forEach (function(node) {
          $scope.sectorsTreeInstance.jstree(true).select_node (node.Sector , true, false);
          $scope.sectorsTreeInstance.jstree(true).select_node (node.Objective , true, false);
        })
      }
  
      $scope.policyInstrumentsTreeInstance.jstree(true).deselect_all(true);
      $scope.policyInstrumentsTreeInstance.jstree('close_all');
      if ($scope.current.PAM.Table1.T261[0].PolicyInstruments) {
        $scope.current.PAM.Table1.T261[0].PolicyInstruments.forEach (function(node) {
          $scope.policyInstrumentsTreeInstance.jstree(true).select_node (node , true, false);
        })
      }
  
        $scope.unionPolicyTreeInstance.jstree(true).deselect_all(true);
        $scope.unionPolicyTreeInstance.jstree('close_all');
        if ($scope.current.PAM.Table1.T261[0].UnionPolicies) {
          $scope.current.PAM.Table1.T261[0].UnionPolicies.forEach (function(node) {
            $scope.unionPolicyTreeInstance.jstree(true).select_node (node.UnionPolicyType , true, false);
            $scope.unionPolicyTreeInstance.jstree(true).select_node (node.UnionPolicy , true, false);
          })
        }
  
        $scope.projectionsScenarioTreeInstance.jstree(true).deselect_all(true);
        if ($scope.current.PAM.Table1.T261[0].ProjectionsScenario) {
            //$scope.projectionsScenarioTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T261[0].ProjectionsScenario.Type , true, false);
            $scope.projectionsScenarioTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T261[0].ProjectionsScenario , true, false);
        }
  
        if ($scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPractices) {
          $scope.ammoniaEmissionsControlPracticesTreeInstance.jstree(true).deselect_all(true);
          $scope.ammoniaEmissionsControlPracticesTreeInstance.jstree('close_all');
          $scope.ammoniaEmissionsControlPracticesTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T264[0].AmmoniaEmissionsControlPractices , true, false);
        }
  
        if ($scope.current.PAM.Table1.T264[0].InorganicFertilisers) {
          $scope.inorganicFertilisersTreeInstance.jstree(true).deselect_all(true);
          $scope.inorganicFertilisersTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T264[0].InorganicFertilisers , true, false);
        }
  
        if ($scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestock) {
          $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).deselect_all(true);
          $scope.ammoniaEmissionsLivestockTreeInstance.jstree('close_all');
          $scope.ammoniaEmissionsLivestockTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T264[0].AmmoniaEmissionsLivestock , true, false);
        }
  
        
        if ($scope.current.PAM.Table1.T264[0].NationalAdvisoryCode) {
          $scope.nationalAdvisoryCodeTreeInstance.jstree(true).deselect_all(true);
          $scope.nationalAdvisoryCodeTreeInstance.jstree('close_all');
          $scope.nationalAdvisoryCodeTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T264[0].NationalAdvisoryCode , true, false);
        }

        /*if ($scope.current.PAM.Table1.T264[0].OpenFieldBurning) {
          $scope.nationalAdvisoryCodeTreeInstance.jstree(true).deselect_all(true);
          $scope.nationalAdvisoryCodeTreeInstance.jstree('close_all');
          $scope.nationalAdvisoryCodeTreeInstance.jstree(true).select_node ($scope.current.PAM.Table1.T264[0].OpenFieldBurning , true, false);
        }*/
      }
    };

/////////////////////////////////////////////////END TREE's STRUCTURES CONTROL/////////////////////////////////////////////////


    // Functions for model manipulation
    
    //from object to array conversion function
    var normalizeArray = function(obj, propertyName) {
      var propertyValue = obj[propertyName];
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

    // Add new row to ng-repeat
    $scope.addItem = function(path) {
        var tokens = path.split(".");
        var result = $scope.current.PAM;
        console.log('result');
        console.log(result);

        tokens.forEach  (function(token) {
          if (token.indexOf("[0]") != -1) {
            result = result[token.substring(0, token.indexOf('[0]'))][0];
          } else {
            result = result[token];
          }
          console.log('result');
          console.log(result);
        });

        var copyOfEmptyInstance = angular.copy($scope.getInstanceByPath('emptyInstance.NEC_PAMs.NEC_PAM',path));   
        console.log('copyOfEmptyInstance');
        console.log(copyOfEmptyInstance);   
        result.push(copyOfEmptyInstance);
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
        tokens.forEach  (function(token) {
          if (token.indexOf("[0]") != -1) {
            result = result[token.substring(0, token.indexOf('[0]'))][0];
          } else {
            result = result[token];
          }
        });
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
      tokens.forEach  (function(token) {
        if (token.indexOf("[0]") != -1) {
          result = result[token.substring(0, token.indexOf('[0]'))];
        } else {
          result = result[token];
        }
      });
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
    $scope.alerts = [];
    
    //$scope.emptyTables = {};
    $scope.current = {};    
    
    //Enable Validation by default
    $scope.ValidationEnabled = true;

    $scope.DoNormalizeArrayEmpty = function(instance, i) {
      console.log('instance in DoNormalizeArrayEmpty');
      console.log(instance);
      if ((!i) || i == null) {i = 0};
      normalizeArray(instance.Table1,"PolicyGroup");          
      normalizeArray(instance.Table1.T261p,"Pollutants");
      //normalizeArray(instance..Table1,"T261");
      normalizeArray(instance.Table1,"T261");
      normalizeArray(instance.Table1.T261[0],"Objectives");
      normalizeArray(instance.Table1.T261[0],"PolicyInstruments");
      normalizeArray(instance.Table1.T261[0],"UnionPolicies");
      //normalizeArray(instance.Table1.T261[0],"Implementation");
      normalizeArray(instance.Table1.T261[0],"ProjectionsScenario");
      normalizeArray(instance.Table1.T261[0],"Entities");
      //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T27p");

      normalizeArray(instance.Table1.T27p,"Indicators");
      normalizeArray(instance.Table1.T27p,"Reference");
      normalizeArray(instance.Table1,"T264");
      normalizeArray(instance.Table1,"T27");
      
      //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T264");
      
  }

    $scope.DoNormalizeArray = function(instance, i) {
        console.log('instance in DoNormalizeArray');
        console.log(instance);
        if ((!i) || i == null) {i = 0};
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"PolicyGroup");          
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261p,"Pollutants");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T261");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"Objectives");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"PolicyInstruments");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"UnionPolicies");
        //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"Implementation");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"ProjectionsScenario");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T261[0],"Entities");
        //normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T27p");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T27p,"Indicators");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1.T27p,"Reference");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T264");
        normalizeArray(instance.NEC_PAMs.NEC_PAM[i].Table1,"T27");
        
    }

    dataRepository.getEmptyInstance()
            .error(function(){alert("Failed to read empty instance XML file."); })
            .success(function(instance) {                                                            
              $scope.emptyInstance = instance;
            });

    dataRepository.getInstance()
            .error(function(){alert("Failed to read instance XML file.");})
            .success(function(instance) {
            if (!angular.isDefined(instance)) { return; }
            normalizeArray(instance.NEC_PAMs,"NEC_PAM");
            for (var i = 0;i < instance.NEC_PAMs.NEC_PAM.length;i++) {
              //Modify Object to use arrays properly
              console.log('DoNormalizeArray');
              $scope.DoNormalizeArray(instance, i);
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
      //$scope.OverviewValidate();
      
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
/*   $scope.isEmpty = function(index,num) {
    if (!$scope.instance || !$scope.emptyInstance || index < 0) { return true; }     
    var tmpSingle = angular.copy(emptyTables['emptyTable' + num]);
    var tmpGroup = angular.copy(emptyTables['emptyTable' + num]);   
    var tmpTable = $scope.instance.NEC_PAMs.NEC_PAM[index]['Table' + num];
    if (num === 1) {
      tmpGroup.isGroup = 'group';
    }
    if (angular.equals(tmpTable,tmpSingle) || angular.equals(tmpTable,tmpGroup)) { return true; }
    else return false;    
   };*/

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

  /**
   * Changes current PAM
   * @param {Number} index
   *
   */
  $scope.setCurrentPam = function(id) {
    if (!$scope.instance.NEC_PAMs.NEC_PAM) { return; }

    /*$scope.current.PAM = _.filter($scope.instance.NEC_PAMs.NEC_PAM, { 'id': id });
       if ($scope.current.PAM.Table1.isGroup == 'single') {
      $scope.setCurrentTreeData();
    };*/

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
    //$scope.OverviewValidate()
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
  $scope.Overview.Table.text1 = [];
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

  $scope.copyPollutantsFromSingle = function (pam, PolicyGroup) {
    var tmpObjFromSingle = [];
    var tmpObjFromPackage = [];
    var tmp;
    //loop over all the single listed in PolicyGroup to find the unique list of pollutants for the package
    PolicyGroup.forEach (function(group){
      tmp = _.filter($scope.instance.NEC_PAMs.NEC_PAM, { 'id': group });
      tmp[0].Table1.T261p.Pollutants.forEach (function(pollutant) {
        tmpObjFromSingle.push(pollutant.Name); 
      });
    });

    //if (pam.Table1.T261p.Pollutants.length > 1) {
      pam.Table1.T261p.Pollutants.forEach (function(pollutant) {
        tmpObjFromPackage.push(pollutant.Name);
      });
    //}

    /*console.log('tmpObjFromSingle');
    console.log(tmpObjFromSingle);

    console.log('tmpObjFromPackage');
    console.log(tmpObjFromPackage);*/

    var tmpObjToPush;
    console.log('pollutant'); //TODO
    _.uniq(_.difference(_.uniq(tmpObjFromSingle), _.uniq(tmpObjFromPackage))).forEach (function(pollutant) {
      tmpObjToPush = angular.copy($scope.getInstanceByPath('emptyInstance.NEC_PAMs.NEC_PAM.Table1','T261p.Pollutants')); 
      console.log('tmpObjToPush');
      console.log(tmpObjToPush);
      console.log('inserting: ' + pollutant);
      tmpObjToPush.Name = pollutant;
      /*tmpObjToPush.Target2020 = null;
      tmpObjToPush.Target2025 = null;
      tmpObjToPush.Target2030 = null;*/
      tmpObjToPush.TargetUnit = 'kt/year';
      pam.Table1.T261p.Pollutants.push(tmpObjToPush);
    });

    _.difference(_.uniq(tmpObjFromPackage), _.uniq(tmpObjFromSingle)).forEach (function(pollutant) {
      console.log('removing: ' + pollutant);
      _.remove(pam.Table1.T261p.Pollutants, {Name: pollutant});
    });

    /*console.log('pam.Table1.T261p.Pollutants');
    console.log(pam.Table1.T261p.Pollutants);*/
  }

  $scope.copyFromSingle = function (pam, tempGroup, element) {
    /*console.log('pam');
    console.log(pam);
    console.log('tempGroup');
    console.log(tempGroup);
    console.log('element');
    console.log(element);*/
    var tmpObj = [];
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
      //console.log('tmp from copyFromSingle');
        //console.log(tmp[element]);
        tmp[element][0].id = tempGroup[i];
        tmpObj.push(tmp[element][0]);
    }
    pam.Table1[element] = tmpObj;
  }

  $scope.setSelectedForAdoptionFromSingle = function (pam, tempGroup) {
    var tmpObj = [];
    var SelectedForAdoption = 'no';
    for (var i = 0; i < tempGroup.length;i++) {
      var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;
        if (tmp.SelectedForAdoption == 'yes') {
          SelectedForAdoption = 'yes';
        };
    }
    console.log('$scope.current.PAM.Table1');
    console.log($scope.current.PAM.Table1)
    $scope.current.PAM.Table1.SelectedForAdoption = SelectedForAdoption;
  
  }

   /**
   * generalized function to get Grouped elements
   * @param {Array} tempGroup
   * @param {String} element
   * @param {Boolean} unique
   */
/*    $scope.Group.getElementsForGroups = function(tempGroup, element, unique) {
      //$scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261p.Pollutants', true);

      var tmpObj = [];
      for (var i = 0; i < tempGroup.length;i++) {
        console.log('console.log(tempGroup[i]);');
        console.log(tempGroup[i]);
        var tmp = $filter('filter')($scope.instance.NEC_PAMs.NEC_PAM, {id: tempGroup[i]}, true)[0].Table1;

        console.log('tmp in getElementsForGroups');
        console.log(tmp);
        //tmp[root][element].forEach(function(elementLoop) {
        //  console.log('elementLoop');
        //  console.log(elementLoop);
        //  elementLoop.id = tempGroup[i];
        //  tmpObj.push(elementLoop);
        //});

        for (var j = 0;j < tmp[element].length;j++) {
          console.log('tmp[element][j]');
          console.log(tmp[element][j]);
          tmp[element][j].id = tempGroup[i];
          tmpObj.push(tmp[element][j]);
        } 
      }
      
      if (unique == true) {
        $scope.current.PAM.Table1[element] = _.uniqWith(tmpObj, _.isEqual);
      } else {
        $scope.current.PAM.Table1[element] = tmpObj;
      }
      console.log('$scope.current.PAM.Table1 in getElementsForGroups');
      console.log($scope.current.PAM.Table1);
    };*/
   
  //Function to get Entities from individual PAMs
/*  $scope.Group.getEntities = function() {      
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
    $scope.current.PAM.Table1.T261[0].Entities = tmpEntities;      
  };*/
    
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
/*  $scope.getNumber = function(number) {
    return new Array(number);
  };*/

/*  $scope.getNumberedArray = function(start,finish) {
    var tmpArray = [];
    for (var i = start; i < finish;i++)
    {
      tmpArray.push(i);
    }
    return tmpArray;
  };*/
  
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
  
  // Function to add a new PAM
  $scope.addPAM = function(goEdit, type) {
    if (!$scope.instance) { return; }
    var clonedEmptyPaM = angular.copy(emptyPam);
    clonedEmptyPaM.id = $scope.getNextId();
    

    //clonedEmptyPaM.Table1.T261[0].Objectives = [];
    //normalizeArray(clonedEmptyPaM.T27p,"Reference");
    
    console.log('clonedEmptyPaM');
    console.log(clonedEmptyPaM);
    clonedEmptyPaM.Table1.isGroup = type;
    if (type === 'group') {
      clonedEmptyPaM.Table1.T261p = {};
      clonedEmptyPaM.Table1.T27p = {};
    }
    
    $scope.setRadioButtons(clonedEmptyPaM);
    $scope.DoNormalizeArrayEmpty(clonedEmptyPaM);
    
    //clonedEmptyPaM.Table1.T261p.Pollutants.TargetUnit = "kt/year";

    $scope.instance.NEC_PAMs.NEC_PAM.push(clonedEmptyPaM);
    
    $timeout(function() {                      
      //$scope.OverviewValidate();
      if (goEdit === true) {
        console.log(1);
        $scope.editTable(clonedEmptyPaM.internalId,1);
        console.log(2);
      }        
    },0);
  };

  $scope.inizializePAM = function(pam) {
    console.log('pam');
    console.log(pam);
    pam.Table1.T261[0].Objectives = [];
  }

  // Function to get year ::ToBeEdited::
/*  $scope.getFutureYear = function(multi) {      
    var tmpYear = $scope.current.reportingYear;
    return ( 5 - ( tmpYear % 5 ) + tmpYear + 5 * multi ) ;
  };*/
   
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
/*    $scope.getIndexForId = function(id) { 
      if (!$scope.instance.NEC_PAMs.NEC_PAM) { return; }
      for (var i=0;i<$scope.instance.NEC_PAMs.NEC_PAM.length;i++) {          
        if ($scope.instance.NEC_PAMs.NEC_PAM[i].id === id) {
          return i;
        }
      }
      return -1;
    };*/
    
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
/*    $scope.isDisabledTable1 = function() {
      if ($scope.isNullEmpty($scope.current.PAM.Title)) return true;
      return false;
    };*/

    /**
     * Calculates all table columns for Overview Table
     *
     */
    $scope.OverviewCalculate = function() {
      $scope.Overview.Table = {};
      $scope.Overview.Table.empty1 = [];
      $scope.Overview.Table.text1 = [];
      for (var i = 0; i < $scope.instance.NEC_PAMs.NEC_PAM.length;i++) {
        //$scope.Overview.Table.empty1[i] = $scope.isEmpty(i,1);
        $scope.Overview.Table.text1[i] = $scope.Overview.Table.empty1[i] === true ? 'Labels.Overview.new_table' : 'Labels.Overview.edit_table';
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

        $scope.Group.calculateGroup(PAM);
        console.log('PAM');
        console.log(PAM);

        if (
          $scope.isNullEmpty(PAM.Title) || 
          $scope.isNullEmpty(PAM.Table1.Description) || 
          $scope.isNull(PAM.Table1.isGroup) ||
          $scope.isNullEmpty(PAM.Table1.T261p.Pollutants) ||
          $scope.isNullEmpty(PAM.Table1.T261[0].Objectives) ||
          $scope.isNullEmpty(PAM.Table1.T261[0].PolicyInstruments) ||
          $scope.isNullEmpty(PAM.Table1.T261[0].Entities) ||
          $scope.isNullEmpty(PAM.Table1.T261[0].DetailsMethodology) 
        ) { valid = false; }
        console.log('1 ' + valid);
        
        if (PAM.Table1.T261[0].QualitativeDescriptionUncertaintiesQuestion == 'yes' && 
            $scope.isNullEmpty(PAM.Table1.T261[0].QualitativeDescriptionUncertainties)
        ) { valid = false; }
        console.log('1b ' + valid);

        if (
          (PAM.Table1.T261[0].Implementation.Start > PAM.Table1.T261[0].Implementation.Finish ||
            PAM.Table1.T261[0].Implementation.Start < 1990 ||
            PAM.Table1.T261[0].Implementation.Start > 2050 ||
            PAM.Table1.T261[0].Implementation.Finish < 1990 ||
            PAM.Table1.T261[0].Implementation.Finish > 9999)
        ) { valid = false; }
        console.log('2 ' + valid);

        if (PAM.Table1.SelectedForAdoption == 'yes') {
          if (
            !$scope.isNullNumber(PAM.Table1.T27[0].AdoptionPlannedYear) ||
            !$scope.isNullNumber(PAM.Table1.T27[0].ReviewTimetable.Start) ||
            !$scope.isNullNumber(PAM.Table1.T27[0].ReviewTimetable.Finish)
            ) { valid = false; }
          
          if (!$scope.isNullNumber(PAM.Table1.T27[0].ReviewTimetable.Start) && !$scope.isNullNumber(PAM.Table1.T27[0].ReviewTimetable.Finish) ) {
            if (
              (PAM.Table1.T27[0].ReviewTimetable.Start > PAM.T27.ReviewTimetable.Finish ||
              PAM.Table1.T27[0].ReviewTimetable.Start < 1990 ||
              PAM.Table1.T27[0].ReviewTimetable.Start > 2050 ||
              PAM.Table1.T27[0].ReviewTimetable.Finish < 2000 ||
              PAM.Table1.T27[0].ReviewTimetable.Finish > 2050) ||
              PAM.Table1.T27[0].AdoptionPlannedYear < 1990 ||
              PAM.Table1.T27[0].AdoptionPlannedYear > 2050
            ) { valid = false; }
          }
        }
        console.log('3 ' + valid);

        //loop over Pollutants
        if (!$scope.isNullEmpty(PAM.Table1.T261p.Pollutants)) {
          PAM.Table1.T261p.Pollutants.forEach(function(pollutant) {
            if ($scope.isNullEmpty(pollutant.Name) || 
                $scope.isNullEmpty(pollutant.Target2020) || 
                $scope.isNullEmpty(pollutant.Target2025) || 
                $scope.isNullEmpty(pollutant.Target2030)
                ) {
              valid = false;
            }
          })
        }
        console.log('4 ' + valid);

        //loop over Objectives
        if (!$scope.isNullEmpty(PAM.Table1.T261[0].Objectives)) {
          PAM.Table1.T261[0].Objectives.forEach(function(objective) {
            /*if ($scope.isNullEmpty(objective.Sector) || 
                $scope.isNullEmpty(objective.SectorDescription) || 
                $scope.isNullEmpty(objective.Objective) || 
                $scope.isNullEmpty(objective.ObjectiveDescription)
                ) {
              valid = false;
            }*/
            if ($scope.isNullEmpty(objective.Objective) 
                ) {
              valid = false;
            }

            if (!$scope.isNullEmpty(objective.Objective) && objective.Objective.includes("_other") && $scope.isNullEmpty(objective.ObjectiveDescription)
                ) {
              valid = false;
            }
          })
        }
        console.log('5 ' + valid);

        //loop over Entities to test Type and Name
        if (!$scope.isNullEmpty(PAM.Table1.T261[0].Entities)) {
          PAM.Table1.T261[0].Entities.forEach(function(entity) {
            if ($scope.isNullEmpty(entity.Type) || $scope.isNullEmpty(entity.Name) ) {
              valid = false;
            }
          })
        }
        console.log('6 ' + valid);

        if (PAM.Table1.T261[0].UnionPolicyRelated == 'yes') {
          if ($scope.isNullEmpty(PAM.Table1.T261[0].UnionPolicy)) { 
            valid = false; 
          } 
          else {
            //loop over UnionPolicy to test all object
            PAM.Table1.T261[0].UnionPolicies.forEach(function(UnionPolicy) {
              if (
                //$scope.isNullEmpty(UnionPolicies.UnionPolicyType) ||
                //$scope.isNullEmpty(UnionPolicies.UnionPolicyTypeDescription) ||
                $scope.isNullEmpty(UnionPolicies.UnionPolicy) ||
                $scope.isNullEmpty(UnionPolicies.UnionPolicyDescription) 
              ) { valid = false; }
            })
          }
        }
        console.log('7 ' + valid);
        
        //Agriculture is a mess :-)
        if(PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesQuestion == 'yes') {
          if (
              $scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsControlPractices) ||
              $scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesPage)
            ) { valid = false; }

          if ($scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesExactly) == 'no') {
            if ($scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsControlPracticesPage)) {
              valid = false;
            }
          }
        }
        console.log('8 ' + valid);

        if(PAM.Table1.T264[0].InorganicFertilisersQuestion == 'yes') {
          if (
              $scope.isNullEmpty(PAM.Table1.T264[0].InorganicFertilisers) ||
              $scope.isNullEmpty(PAM.Table1.T264[0].InorganicFertilisersPage)
            ) { valid = false; }

          if ($scope.isNullEmpty(PAM.Table1.T264[0].InorganicFertilisersExactly) == 'no') {
            if ($scope.isNullEmpty(PAM.Table1.T264[0].InorganicFertilisersExactlyReason)) {
              valid = false;
            }
          }
        }
        console.log('9 ' + valid);
       
        if(PAM.Table1.T264[0].AmmoniaEmissionsLivestockQuestion == 'yes') {
          if (
              $scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsLivestock) ||
              $scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsLivestockPage)
            ) { valid = false; }

            console.log('10a ' + valid);
          if ($scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsLivestockExactly) == 'no') {
            if ($scope.isNullEmpty(PAM.Table1.T264[0].AmmoniaEmissionsLivestockExactlyReason)) {
              valid = false;
            }
          }
          console.log('10b ' + valid);
        }
        console.log('10 ' + valid);

        if(PAM.Table1.T264[0].NationalAdvisoryCodeQuestion == 'yes') {
          if (
              $scope.isNullEmpty(PAM.Table1.T264[0].NationalAdvisoryCode)
            ) { valid = false; }
        }
        console.log('11 ' + valid);

        $scope.temp.Validation['ID' + PAM.internalId] = {};
        $scope.temp.Validation['ID' + PAM.internalId]['Table1'] = valid;
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

    function stringIsNumber(obj) {
      var x = +obj; // made cast obvious for demonstration
      return x.toString() === obj;
    }

    /**
     * Checks if object is null or not a number
     * @param {type} obj
     * @returns {Boolean} true if object is null or not a number
     */
    $scope.isNullNumber = function(obj) {
      if (!obj || !angular.isNumber(obj) || stringIsNumber(obj) == false) {
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

      console.log('$scope.temp.Validation');
      console.log($scope.temp.Validation);

     var tmp = Object.keys($scope.temp.Validation);
     var isValid = true;
     for (var i = 0; i < tmp.length;i++) {
        if (!$scope.temp.Validation[tmp[i]]['Table1']) {
          isValid = false;
          //reenablebreak!!
          break;
        }     
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
          tmpScope.NEC_PAMs.NEC_PAM[i].Table1.UnionPolicies = [];
        }
      }
      //Sort the PaMs before saving, so they are properly ordered in the xml-file for viewing in print-preview etc. 
      tmpScope.NEC_PAMs.NEC_PAM = $filter('orderBy')(tmpScope.NEC_PAMs.NEC_PAM, 'id');
      dataRepository.saveInstance(tmpScope)
        .error(function() {
          alert("Error! Data is not saved! Please try again");
          $scope.Webform.$setPristine(false);
          $scope.temp.SaveDisabled = false;
          $scope.temp.disableWatchers = false;
        })
        .success(function(data,status){
            $scope.temp.SaveDisabled = false;
            $scope.temp.disableWatchers = false;
            if (data.code === 1) {
            //Validation functionality
              //Always validate on Save
              if ($scope.ValidationEnabled) {
                //$scope.OverviewValidate();
                $scope.temp.isValid = false;              
                if ($scope.isValid()) $scope.temp.isValid = true;
                if (!$scope.temp.isValid) { alert("Data Saved, but Webform contains validation errors"); }
                else alert(data.message);
              }
              else alert(data.message);
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
    
    //var emptyTables = {
    //  emptyTable1: emptyPam.Table1
    //};       
    // disable function for select fields 
    $scope.searchEnabled = false;
        
    //temp scope variables
    $scope.temp.overview = [{}];
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
    $scope.addPAM(false, 'single');
    $scope.setCurrentPam(1);
    
    $scope.hideAgricultureObjects();

    // Watch empty instance
    $scope.$watch('emptyInstance', function(newValue, oldValue) {
      if (!angular.isDefined(newValue)) { return; }
      if (!angular.isDefined(newValue.NEC_PAMs)) { return; }              
    });
    
    /*$scope.Table1ClearUnionPolicy = function() {
      $timeout(function() { $scope.current.PAM.Table1.T261[0].UnionPolicies = []; },0);
    };*/


    // Clear list of other union policies when "Other (Union policy not listed above or additional Union policy)" is not selected 
    /*$scope.UpdateOtherPolicies = function() {
      if ($scope.current.PAM.Table1.T261[0].UnionPolicies.indexOf("Other_EU") === -1 && $scope.current.PAM.Table1.T261[0].UnionPolicyOther.length > 0 && $scope.current.PAM.Table1.T261[0].UnionPolicyOther[0].Name != null) {
        $scope.current.PAM.Table1.T261[0].UnionPolicyOther.length = 0; //Clear array
        $scope.addItem('Table1.UnionPolicyOther');
      }
    };*/
   
    // Model manipulation watchers for single or group
    $scope.$watch('current.PAM.Table1.isGroup', function(newValue, oldValue) {  
      console.log('is group!');    
      if ($scope.temp.disableWatchers) { return; }
      if (newValue === 'single') {        
        $scope.current.PAM.Table1.PolicyGroup = [];
        $scope.temp.isGroup = false;        
      }
      else if (newValue === 'group') {        
        $scope.temp.isGroup = true;
        //$scope.Group.calculateGroup();        
      }
    }); 

    //returns the pam object when isGroup == 'group'
    $scope.getGroupPam = function (arr) {
      return arr.filter(function (obj) {
        if (obj.Table1.isGroup === 'group') {
          return true;
        }
        return false;
      });
    };

    // Model manipulation watchers for single or group

    //when single BelongsToPackage == 'yes' and assigned to package, but suddenly set 
    // BelongsToPackage == 'no', it must be removed from the package
    $scope.$watch('current.PAM.Table1.BelongsToPackage', function(newValue, oldValue) {   
      //var myArr = [];
      if ($scope.temp.disableWatchers) { return; }
      if (newValue === 'no') {
        //myArr = $scope.getGroupPam($scope.instance.NEC_PAMs.NEC_PAM);
        //myArr.forEach (function(pam) {
        $scope.getGroupPam($scope.instance.NEC_PAMs.NEC_PAM).forEach (function(pam) {
          pam.Table1.PolicyGroup = _.remove(pam.Table1.PolicyGroup, function(n) { return n != $scope.current.PAM.id; });
          //$scope.Group.calculateGroup(pam, pam.Table1.PolicyGroup);
          if (pam.Table1.PolicyGroup) {
            $scope.setSelectedForAdoptionFromSingle(pam, pam.Table1.PolicyGroup);
          }
          $scope.copyPollutantsFromSingle(pam, pam.Table1.PolicyGroup);
          $scope.copyFromSingle(pam, $scope.current.PAM.Table1.PolicyGroup, 'T261', true);
        });
      }
    });
    
    $scope.$watchCollection('current.PAM.Table1.PolicyGroup', function(newValue,oldValue) {
      console.log('PolicyGroup watcher!');
      if ($scope.temp.disableWatchers) { return; }
      if ($scope.temp.SaveDisabled) { return; }
      console.log('newValue: ' + newValue);
      //$scope.Group.calculateGroup($scope.current.PAM, newValue);
      console.log('$scope.current.PAM');
      console.log($scope.current.PAM);
      if ($scope.current.PAM.Table1.isGroup == 'group' && $scope.current.PAM.Table1.PolicyGroup) {
        $scope.setSelectedForAdoptionFromSingle($scope.current.PAM, $scope.current.PAM.Table1.PolicyGroup);
        $scope.copyPollutantsFromSingle($scope.current.PAM, $scope.current.PAM.Table1.PolicyGroup);
        $scope.copyFromSingle($scope.current.PAM, $scope.current.PAM.Table1.PolicyGroup, 'T261', true);
      }
      
      /*if (!$scope.isNullEmpty(newValue)) {
        $scope.Group.calculateGroup(newValue);
      }*/
    });

    $scope.$watchCollection('current.PAM.Table1.SelectedForAdoption', function(newValue,oldValue) {
      if ($scope.temp.disableWatchers) { return; }
      if ($scope.temp.SaveDisabled) { return; }
      var copyOfEmptyInstance;
      if (newValue == 'no' && ($scope.current.PAM.Table1.T27[0])) {
        copyOfEmptyInstance = angular.copy($scope.getInstanceByPath('emptyInstance.NEC_PAMs.NEC_PAM','Table1.T27'));
        if (copyOfEmptyInstance) {
          $scope.current.PAM.Table1.T27 = [];
          $scope.current.PAM.Table1.T27.push(copyOfEmptyInstance);
        }
      }

      if (newValue == 'no' && ($scope.current.PAM.Table1.T27p)) {
        copyOfEmptyInstance = angular.copy($scope.getInstanceByPath('emptyInstance.NEC_PAMs.NEC_PAM','Table1.T27p'));
        if (copyOfEmptyInstance) {
          normalizeArray(copyOfEmptyInstance,"Indicators");
          normalizeArray(copyOfEmptyInstance,"Reference");
          $scope.current.PAM.Table1.T27p = copyOfEmptyInstance;
        }
      }
      
      /*if (!$scope.isNullEmpty(newValue)) {
        $scope.Group.calculateGroup(newValue);
      }*/
    });

    //ng-show="current.PAM.Table1.T264[0].
    //Function to calculate group values and change instance file

    //TODO
    $scope.Group.calculateGroup = function(pam, PolicyGroup) {


      /*console.log('calculateGroup');
      console.log('pam');
      console.log(pam);
      console.log('PolicyGroup');
      console.log(PolicyGroup);*/
      if (pam.Table1.isGroup !== 'group') { return; }
      if (pam.Table1.PolicyGroup) {
        //$scope.Group.getSectors($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261p', 'Pollutants', true);
        /*$scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', 'Objectives', true);
        $scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', 'PolicyInstruments', true);
        $scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', 'UnionPolicies', true);
        $scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', 'Implementation', false);
        $scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', 'ProjectionsScenario', false);*/
        //$scope.Group.getElementsForGroups($scope.current.PAM.Table1.PolicyGroup, 'T261[0]', true);
        
        //redundant
        $scope.copyFromSingle(pam, pam.Table1.PolicyGroup, 'T261', true);

        $scope.copyFromSingle(pam, pam.Table1.PolicyGroup, 'T264', true);

        $scope.copyFromSingle(pam, pam.Table1.PolicyGroup, 'T27', true);

        //$scope.setSelectedForAdoptionFromSingle(pam, pam.Table1.PolicyGroup);
        //$scope.Group.getPollutants($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getObjectives($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getPolicyInstrument($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getUnionPolicies($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getImplementation($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getEnvisaged();
        //$scope.Group.getPolicyImpact();
        //$scope.Group.getEntities($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getScenarios($scope.current.PAM.Table1.PolicyGroup);
        //$scope.Group.getAgriculture($scope.current.PAM.Table1.PolicyGroup);
      }
      //$scope.copyPollutantsFromSingle(pam, pam.Table1.PolicyGroup);
    };
    
    //Function to run Group Calculations for every PAM in Webform
/*    $scope.Group.calculateAll = function() {      
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
    };*/
      
    // Watch Collection to recreate ID's on PAM add or removal
    $scope.$watchCollection('instance.NEC_PAMs.NEC_PAM', function(newPAMs,oldPAMs) {
      if (newPAMs.length > oldPAMs.length) {
        for (var i = 0; i < newPAMs.length;i++) {
          if (!angular.isDefined($scope.Overview.Table.empty1[i])) {
            $scope.Overview.Table.empty1[i] = true;
            $scope.Overview.Table.text1[i] = 'Labels.Overview.new_table';
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
        $scope.current.PAM.Table1.T261[0].Objectives = [];
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
              url = getWebQUrl("/download/user_file"); 
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
        
        if (dateField == "table1_ImplementationPeriodStart" && dateValue < currentYear ) {
          ctrl.$setValidity('matchesPlannedStatus', false); //set 'invalid'
          return viewValue;
        }

        if (dateField == "table1_ImplementationPeriodFinish" && dateValue > currentYear ) {
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
