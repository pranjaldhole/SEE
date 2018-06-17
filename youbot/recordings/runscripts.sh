cp read.py big/left
cp read.py big/right
cp read.py big/straight
cp read.py medium/left
cp read.py medium/right
cp read.py medium/straight
cp read.py small/left
cp read.py small/right
cp read.py small/straight


cd big/left
python read.py big_left
cd ../right
python read.py big_right
cd ../straight
python read.py big_straight


cd ../../medium/left
python read.py medium_left
cd ../right
python read.py medium_right
cd ../straight
python read.py medium_straight

cd ../../small/left
python read.py small_left
cd ../right
python read.py small_right
cd ../straight
python read.py small_straight
