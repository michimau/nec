--General Information--
create table db_info(last_modified TIMESTAMP);
create table data_report(report_id varchar(255) PRIMARY KEY,country varchar(2),report_year smallint, report_submission_date TIMESTAMP, envelope_url varchar(255), filename varchar(255), is_released varchar(20), language varchar(2));

--Table1--
create table table1(report_id varchar(255), id int, Title varchar(255), isGroup varchar(8), ObjectiveQuantified varchar(255), Description varchar(255), isEnvisaged varchar(8), UnionPolicyRelated varchar(3), Reference_Text varchar(255), Reference_Url varchar(500), Comments varchar(500), PRIMARY KEY(report_id, id), CONSTRAINT fk_report_id FOREIGN KEY(report_id) REFERENCES data_report(report_id));
create table table1_PolicyGroup(report_id varchar(255), id int, policyGroupId int, PRIMARY KEY(report_id,id,policyGroupId), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table1_Sectors(report_id varchar(255), id int, sectorCode varchar(255), shortSectorCode varchar(4), PRIMARY KEY(report_id,id,sectorCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_Sectors(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_GreenhouseGases(report_id varchar(255), id int, greenhouseGasCode varchar(255), PRIMARY KEY(report_id,id,greenhouseGasCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_GreenhouseGases(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_Objective(report_id varchar(255), id int, objectiveCode varchar(255), PRIMARY KEY(report_id,id,objectiveCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_Objective(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_ObjectiveOther(report_id varchar(255), id int, shortSectorCode varchar(4), objectiveOther varchar(255), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_ObjectiveOther(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_PolicyInstrument(report_id varchar(255), id int, policyInstrumentCode varchar(255), PRIMARY KEY(report_id,id,policyInstrumentCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_PolicyInstrument(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_UnionPolicy(report_id varchar(255), id int, unionPolicyCode varchar(255), PRIMARY KEY(report_id,id,unionPolicyCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_UnionPolicy(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_UnionPolicyOther(report_id varchar(1000), id int, unionPolicyOther varchar(255), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table1_Implementation(report_id varchar(255), id int, pamNumber int, status varchar(255), start int, finish int, PRIMARY KEY(report_id,id,pamNumber), CONSTRAINT fk_report_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table1_ProjectionsScenario(report_id varchar(255), id int, pamNumber int, projectionsScenarioCode varchar(255), PRIMARY KEY(report_id,id,pamNumber), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_ProjectionsScenario(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_Entities(report_id varchar(255), id int, type varchar(255), name varchar(255), PRIMARY KEY(report_id,id,type,name), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table Labels_table1_Entities(code varchar(255),labels varchar(255), PRIMARY KEY(code));
create table table1_Indicators(report_id varchar(255), id int, description varchar(1000), unit varchar(255), year1 int, year2 int, year3 int, year4 int, value1 decimal, value2 decimal,value3 decimal, value4 decimal, PRIMARY KEY(report_id,id,description), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));

--Table1 Labels --
create table Labels_table1(code varchar(255),labels varchar(255), PRIMARY KEY(code));

--Table2--
create table table2(report_id varchar(255), id int, ExpostExplanation varchar(500), ExpostFactors varchar(255), PRIMARY KEY(report_id,id), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));

create table table2_PolicyImpact(report_id varchar(255), id int, policyImpactCode varchar(255), PRIMARY KEY(report_id,id,policyImpactCode), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table2_ExanteEmissions(report_id varchar(255), id int, ghgYear int, eu_ets decimal, esd decimal, total decimal, PRIMARY KEY(report_id,id,ghgYear), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table2_ExanteDocumentation(report_id varchar(255),id int, reference varchar(255), weblink varchar(500), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table2_Expost(report_id varchar(255),id int, ghgYear int, average decimal, PRIMARY KEY(report_id,id,ghgYear), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table2_ExpostDocumentation(report_id varchar(255),id int, reference varchar(255), weblink varchar(500), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));

--Table3--
create table table3(report_id varchar(255), id int, Projected_costReduced decimal, Projected_benefitReduced decimal, Projected_netcostReduced decimal, Projected_costAbsolute decimal, Projected_benefitAbsolute decimal, Projected_netcostAbsolute decimal, Projected_costYear int, Projected_priceReferenceYear int, Projected_description varchar(500), Realised_costReduced decimal, Realised_benefitReduced decimal, Realised_netcostReduced decimal, Realised_costAbsolute decimal, Realised_benefitAbsolute decimal, Realised_netcostAbsolute decimal, Realised_costYear int, Realised_priceReferenceYear int, Realised_description varchar(500));
create table table3_ProjectedDocumentation(report_id varchar(255),id int, reference varchar(255), weblink varchar(500), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));
create table table3_RealisedDocumentation(report_id varchar(255),id int, reference varchar(255), weblink varchar(500), CONSTRAINT fk_report_id_id FOREIGN KEY(report_id,id) REFERENCES table1(report_id,id));