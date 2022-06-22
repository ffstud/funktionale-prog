
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

public class Main {

	private final static List<Person> INIT_DATA = Arrays.asList(
			new Person("Andreas", "Mueller", new Date(1900, 01, 01)),
			new Person("Andreas", "Mayer", new Date(1900, 01, 01)),
			new Person("Andreas", "Huber", new Date(1900, 01, 01)),
			new Person("Thomas", "Mueller", new Date(1900, 01, 01)),
			new Person("Thomas", "Gruber", new Date(1900, 01, 01)),
			new Person("Michael", "Moser", new Date(1900, 01, 01)));

	public static void main(String[] args) {
		ManagerInterface m = new Manager();

		INIT_DATA.forEach(m::add);

		//1. get and print first person with first name "Thomas"
		Person firstThomas = m.getFirst(x->x.getFirstName().equals("Thomas"));
		System.out.println(firstThomas);

		//2. get all persons with first name == Andreas;
		List<Person> allAndreas = m.getAll(x->x.getFirstName().equals("Andreas"));

		//3. get first person with last name starts with 'G' (use Optional!!!)
		Optional<Person> firstGruber = m.getFirstOptional(x->x.getLastName().startsWith("G"));

		//4. print firstGuber only if the value is not empty (use a Consumer and "method reference")
		firstGruber.ifPresent(System.out::println);

		System.out.println("---");

		//5. print all persons stored in Manager
		m.getAll(Objects::nonNull).forEach(System.out::println);

		//6. output all persons stored in Manager grouped by their first name
		m.getAll(Objects::nonNull).stream().collect(Collectors.groupingBy(Person::getFirstName));

		System.out.println("---");

		//7. output all last names of persons ending with "uber" separated by
		//   commas (and in natural order): --> "Gruber, Huber"
		m.getAll(x->x.getLastName().endsWith("uber")).stream().sorted(Comparator.comparing(Person::getLastName)).forEach(s-> System.out.print(s.getLastName()+", "));
	}

}
