#!/usr/bin/env perl

use strict;
use warnings;

use CSS::Struct::Output::Indent;
use Data::Navigation::Item;
use Tags::HTML::Navigation::Grid;
use Tags::Output::Indent;

# Object.
my $css = CSS::Struct::Output::Indent->new;
my $tags = Tags::Output::Indent->new;
my $obj = Tags::HTML::Navigation::Grid->new(
        'css' => $css,
        'tags' => $tags,
);

my @items = (
        Data::Navigation::Item->new(
                'class' => 'nav-item1',
                'desc' => 'This is description #1',
                'id' => 1,
                'image' => '/img/foo.png',
                'location' => '/first',
                'title' => 'First',
        ),
        Data::Navigation::Item->new(
                'class' => 'nav-item2',
                'desc' => 'This is description #2',
                'id' => 2,
                'image' => '/img/bar.png',
                'location' => '/second',
                'title' => 'Second',
        ),
);
$obj->init(\@items);

# Process login b.
$obj->process_css;
$obj->process;

# Print out.
print "CSS\n";
print $css->flush."\n\n";
print "HTML\n";
print $tags->flush."\n";

# Output:
# CSS
# .navigation {
#         display: flex;
#         flex-wrap: wrap;
#         gap: 20px;
#         padding: 20px;
#         justify-content: center;
# }
# .nav-item {
#         display: flex;
#         flex-direction: column;
#         align-items: center;
#         border: 2px solid #007BFF;
#         border-radius: 15px;
#         padding: 15px;
#         width: 200px;
# }
# .nav-item img {
#         width: 100px;
#         height: 100px;
# }
# .nav-item h3 {
#         margin: 10px 0;
#         font-family: sans-serif;
# }
# .nav-item  {
#         text-align: center;
#         font-family: sans-serif;
# }
# 
# HTML
# <nav class="navigation">
#   <div class="nav-item1">
#     <img src="/img/foo.png" alt="First">
#     </img>
#     <h3>
#       <a href="/first">
#         First
#       </a>
#     </h3>
#     <p>
#       This is description #1
#     </p>
#   </div>
#   <div class="nav-item2">
#     <img src="/img/bar.png" alt="Second">
#     </img>
#     <h3>
#       <a href="/second">
#         Second
#       </a>
#     </h3>
#     <p>
#       This is description #2
#     </p>
#   </div>
# </nav>