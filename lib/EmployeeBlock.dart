import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "John1", 10000),
    Employee(2, "John2", 20000),
    Employee(3, "John3", 30000),
    Employee(4, "John4", 40000)
  ];

  final _employeeListStreamController = StreamController<List<Employee>>();

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);

    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  void _incrementSalary(Employee employee) {
    double increment = employee.salary * 20 / 100;
    _employeeList[employee.id - 1].salary = employee.salary + increment;
    employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee employee) {
    double decrement = employee.salary * 20 / 100;
    _employeeList[employee.id - 1].salary = employee.salary - decrement;
    employeeListSink.add(_employeeList);
  }

  void dispose(){
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
