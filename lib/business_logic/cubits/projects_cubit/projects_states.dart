abstract class ProjectsStates{}

class InitialState extends  ProjectsStates{}

class ProjectsLoaded extends  ProjectsStates{}

class ProjectDataLoaded extends  ProjectsStates{}

class ProjectDataLoadingError extends  ProjectsStates{}

class ChangingGridSize extends  ProjectsStates{}