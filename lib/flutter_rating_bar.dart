import 'package:flutter/material.dart';

class RatingWidget {
  final Widget full;

  final Widget half;

  final Widget empty;

  RatingWidget({
    @required this.full,
    @required this.half,
    @required this.empty,
  });
}

class _HalfRatingWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color unratedColor;

  _HalfRatingWidget({
    @required this.size,
    @required this.child,
    @required this.enableMask,
    @required this.rtlMode,
    @required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingWidget(
                    child: child,
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              child: child,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  final bool rtlMode;

  _HalfClipper({
    @required this.rtlMode,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _NoRatingWidget extends StatelessWidget {
  final double size;
  final Widget child;
  final bool enableMask;
  final Color unratedColor;

  _NoRatingWidget({
    @required this.size,
    @required this.child,
    @required this.enableMask,
    @required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? _ColorFilter(
                color: unratedColor,
                child: child,
              )
            : child,
      ),
    );
  }
}

class _ColorFilter extends StatelessWidget {
  final Widget child;
  final Color color;

  _ColorFilter({
    @required this.child,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcATop,
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcATop,
        ),
        child: child,
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  final double ratingFraction;
  final bool rtlMode;

  _IndicatorClipper({
    this.ratingFraction,
    this.rtlMode = false,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width - size.width * ratingFraction,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width * ratingFraction,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class RatingBarIndicator extends StatefulWidget {

  final double rating;

  final int itemCount;

  final double itemSize;

  final EdgeInsets itemPadding;

  final ScrollPhysics physics;

  final TextDirection textDirection;

  final IndexedWidgetBuilder itemBuilder;

  final Axis direction;

  final Color unratedColor;

  RatingBarIndicator({
    @required this.itemBuilder,
    this.rating = 0.0,
    this.itemCount = 5,
    this.itemSize = 40.0,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.physics = const NeverScrollableScrollPhysics(),
    this.textDirection,
    this.direction = Axis.horizontal,
    this.unratedColor,
  });

  @override
  _RatingBarIndicatorState createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0.0;
  int _ratingNumber = 0;
  bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) ==
        TextDirection.rtl;
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: widget.physics,
      child: widget.direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            ),
    );
  }

  List<Widget> _children() {
    return List.generate(
      widget.itemCount,
      (index) {
        if (widget.textDirection != null) {
          if (widget.textDirection == TextDirection.rtl &&
              Directionality.of(context) != TextDirection.rtl) {
            return Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              alignment: Alignment.center,
              transformHitTests: false,
              child: _buildItems(index),
            );
          }
        }
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) => Padding(
        padding: widget.itemPadding,
        child: SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: index + 1 < _ratingNumber
                    ? widget.itemBuilder(context, index)
                    : _ColorFilter(
                        color: widget.unratedColor ?? Colors.grey[200],
                        child: widget.itemBuilder(context, index),
                      ),
              ),
              if (index + 1 == _ratingNumber)
                _isRTL
                    ? FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                            rtlMode: _isRTL,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      ),
            ],
          ),
        ),
      );
}

class RatingBar extends StatefulWidget {

  final int itemCount;

  final double initialRating;

  final ValueChanged<double> onRatingUpdate;

  final double itemSize;

  final bool allowHalfRating;

  final EdgeInsets itemPadding;

  final bool ignoreGestures;

  final bool tapOnlyMode;

  final TextDirection textDirection;

  final IndexedWidgetBuilder itemBuilder;

  final RatingWidget ratingWidget;

  final bool glow;

  final double glowRadius;

  final Color glowColor;

  final Axis direction;

  final Color unratedColor;

  final double minRating;

  final double maxRating;

  RatingBar({
    this.itemCount = 5,
    this.initialRating = 0.0,
    @required this.onRatingUpdate,
    this.itemSize = 40.0,
    this.allowHalfRating = false,
    this.itemBuilder,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.ignoreGestures = false,
    this.tapOnlyMode = false,
    this.textDirection,
    this.ratingWidget,
    this.glow = true,
    this.glowRadius = 2,
    this.direction = Axis.horizontal,
    this.glowColor,
    this.unratedColor,
    this.minRating = 0,
    this.maxRating,
  }) : assert(
          (itemBuilder == null && ratingWidget != null) ||
              (itemBuilder != null && ratingWidget == null),
          'itemBuilder and ratingWidget can\'t be initialized at the same time.'
          'Either remove ratingWidget or itembuilder.',
        );

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _rating = 0.0;

  double iconRating = 0.0;
  double _minRating, _maxrating;
  bool _isRTL = false;
  ValueNotifier<bool> _glow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) ==
        TextDirection.rtl;
    iconRating = 0.0;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
        direction: widget.direction,
        children: List.generate(
          widget.itemCount,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    Widget ratingWidget;
    if (index >= _rating) {
      ratingWidget = _NoRatingWidget(
        size: widget.itemSize,
        child: widget.ratingWidget?.empty ?? widget.itemBuilder(context, index),
        enableMask: widget.ratingWidget == null,
        unratedColor: widget.unratedColor ?? Colors.grey[200],
      );
    } else if (index >= _rating - (widget.allowHalfRating ? 0.5 : 1.0) &&
        index < _rating &&
        widget.allowHalfRating) {
      if (widget.ratingWidget?.half == null) {
        ratingWidget = _HalfRatingWidget(
          size: widget.itemSize,
          child: widget.itemBuilder(context, index),
          enableMask: widget.ratingWidget == null,
          rtlMode: _isRTL,
          unratedColor: widget.unratedColor ?? Colors.grey[200],
        );
      } else {
        ratingWidget = SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: widget.ratingWidget.half,
                  )
                : widget.ratingWidget.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      ratingWidget = SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: FittedBox(
          fit: BoxFit.contain,
          child:
              widget.ratingWidget?.full ?? widget.itemBuilder(context, index),
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTap: () {
          if (widget.onRatingUpdate != null) {
            widget.onRatingUpdate(index + 1.0);
            setState(() {
              _rating = index + 1.0;
            });
          }
        },
        onHorizontalDragStart: _isHorizontal ? (_) => _glow.value = true : null,
        onHorizontalDragEnd: _isHorizontal
            ? (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              }
            : null,
        onHorizontalDragUpdate: _isHorizontal
            ? (dragUpdates) => _dragOperation(dragUpdates, widget.direction)
            : null,
        onVerticalDragStart: _isHorizontal ? null : (_) => _glow.value = true,
        onVerticalDragEnd: _isHorizontal
            ? null
            : (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              },
        onVerticalDragUpdate: _isHorizontal
            ? null
            : (dragUpdates) => _dragOperation(dragUpdates, widget.direction),
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder(
            valueListenable: _glow,
            builder: (context, glow, _) {
              if (glow && widget.glow) {
                Color glowColor =
                    widget.glowColor ?? Colors.transparent;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(0),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(0),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: ratingWidget,
                );
              } else {
                return ratingWidget;
              }
            },
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => widget.direction == Axis.horizontal;

  void _dragOperation(DragUpdateDetails dragDetails, Axis direction) {
    if (!widget.tapOnlyMode) {
      RenderBox box = context.findRenderObject();
      var _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (direction == Axis.horizontal) {
        i = _pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      }
      var currentRating = widget.allowHalfRating ? i : i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget.direction == Axis.horizontal) {
        currentRating = widget.itemCount - currentRating;
      }
      if (widget.onRatingUpdate != null) {
        if (currentRating < _minRating) {
          _rating = _minRating;
        } else if (currentRating > _maxrating) {
          _rating = _maxrating;
        } else {
          _rating = currentRating;
        }
        setState(() {});
      }
    }
  }
}
