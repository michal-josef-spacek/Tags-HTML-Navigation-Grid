package Tags::HTML::Navigation::Grid;

use base qw(Tags::HTML);
use strict;
use warnings;

use Class::Utils qw(set_params split_params);
use Error::Pure qw(err);
use Scalar::Util qw(blessed);

our $VERSION = 0.01;

# Constructor.
sub new {
	my ($class, @params) = @_;

	# Create object.
	my ($object_params_ar, $other_params_ar) = split_params(
		['css_class'], @params);
	my $self = $class->SUPER::new(@{$other_params_ar});

	# CSS class.
	$self->{'css_class'} = 'navigation';

	# Process params.
	set_params($self, @{$object_params_ar});

	if (! defined $self->{'css_class'}) {
		err "Parameter 'css_class' is required.";
	}

	# Object.
	return $self;
}

sub _cleanup {
	my $self = shift;

	delete $self->{'_items'};

	return;
}

sub _init {
	my ($self, $items_ar) = @_;

	if (ref $items_ar ne 'ARRAY') {
		err "Bad reference to array with items.";
	}

	foreach my $item (@{$items_ar}) {
		if (! defined $item
			|| ! blessed($item)
			|| ! $item->isa('Data::Navigation::Item')) {

			err "Item object must be a 'Data::Navigation::Item' instance.";
		}
	}

	$self->{'_items'} = $items_ar;

	return;
}

# Process 'Tags'.
sub _process {
	my $self = shift;

	if (! exists $self->{'_items'}) {
		return;
	}

	$self->{'tags'}->put(
		['b', 'nav'],
		['a', 'class', $self->{'css_class'}],
	);
	foreach my $item (@{$self->{'_items'}}) {
		$self->{'tags'}->put(
			['b', 'div'],
			defined $item->class ? (
				['a', 'class', $item->class],
			) : (
				['a', 'class', 'nav-item'],
			),
			defined $item->image ? (
				['b', 'img'],
				['a', 'src', $item->image],
				['a', 'alt', $item->title],
				['e', 'img'],
			) : (),
			['b', 'h3'],
			defined $item->location ? (
				['b', 'a'],
				['a', 'href', $item->location],
			) : (),
			['d', $item->title],
			defined $item->location ? (
				['e', 'a'],
			) : (),
			['e', 'h3'],
			defined $item->desc ? (
				['b', 'p'],
				['d', $item->desc],
				['e', 'p'],
			) : (),
			['e', 'div'],
		);
	}
	$self->{'tags'}->put(
		['e', 'nav'],
	);

	return;
}

sub _process_css {
	my $self = shift;

	if (! exists $self->{'_items'}) {
		return;
	}

	$self->{'css'}->put(
		['s', '.'.$self->{'css_class'}],
		['d', 'display', 'flex'],
		['d', 'flex-wrap', 'wrap'],
		['d', 'gap', '20px'],
		['d', 'padding', '20px'],
		['d', 'justify-content', 'center'],
		['e'],

		['s', '.nav-item'],
		['d', 'display', 'flex'],
		['d', 'flex-direction', 'column'],
		['d', 'align-items', 'center'],
		['d', 'border', '2px solid #007BFF'],
		['d', 'border-radius', '15px'],
		['d', 'padding', '15px'],
		['d', 'width', '200px'],
		['e'],

		['s', '.nav-item img'],
		['d', 'width', '100px'],
		['d', 'height', '100px'],
		['e'],

		['s', '.nav-item h3'],
		['d', 'margin', '10px 0'],
		['d', 'font-family', 'sans-serif'],
		['e'],

		['s', '.nav-item '],
		['d', 'text-align', 'center'],
		['d', 'font-family', 'sans-serif'],
		['e'],
	);

	return;
}

1;

__END__
