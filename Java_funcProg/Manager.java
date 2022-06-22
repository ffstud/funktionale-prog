import java.util.*;
import java.util.function.Predicate;

public class Manager implements ManagerInterface{
    private List<Person> ls= new ArrayList<>();

    @Override
    public boolean add(Person p) {
        return ls.add(p);
    }

    @Override
    public boolean remove(Person p) {
        return ls.remove(p);
    }

    @Override
    public Person getFirst(Predicate<Person> pred) {
        return ls.stream().filter(pred).findFirst().orElse(null);
    }

    @Override
    public Optional<Person> getFirstOptional(Predicate<Person> pred) {
        return ls.stream().filter(pred).findFirst();
    }

    @Override
    public List<Person> getAll(Predicate<Person> pred) {
        return ls.stream().filter(pred).toList();
    }
}
