Subroutine timeseries(m, infile, outfile)
integer, intent(in) ::  m
character(LEN=100) :: infile, outfile  
integer :: i
real, dimension(3) :: h1, h2, h3, o, orthoH1toH3,  h2toh1
real :: s, t=0.0 !, binwidth = 0.05
character (LEN=1) :: skipacharacter
real, dimension(3) :: REFAXIS, averagevector
real, dimension(40) :: counter


	open(unit = 11,file=infile, status = 'old', action = 'read')
	Open(unit=10, Status='replace', file=outfile, action='write')

	counter = 0.0
	do i=1, m
		t = t + 1.0
		read(11,*)
		read(11,*)
		read(11,*)skipacharacter,O
		read(11,*)skipacharacter,h1
		read(11,*)skipacharacter,h2
		read(11,*)skipacharacter,h3

		averagevector = (H1+H2+h3-3.0*O)/3.0

		h2toh1 = h2 - h1
		h2toh1 = h2toh1/(sqrt(dot_product(h2toh1,h2toh1)))


		!using the gram-schmidt procedure to get orthoh1toh3(a vector perpendicular to h2toh1)
		orthoH1toH3 = (h3-h1) - ((dot_product(h3-h1,h2toh1))*(h2toh1))/((h2toh1(1)**2  + h2toh1(2)**2 + h2toh1(3)**2))
		orthoH1toH3= orthoH1toH3/(sqrt(dot_product(orthoH1toH3,orthoH1toH3)))
		!finding the vector perpendicular to it using the crossproduct of orthoH1toH3 with h2toH1
		REFAXIS(1) = orthoH1toH3(2)*h2toh1(3) - orthoH1toH3(3)*h2toh1(2)
		REFAXIS(2) = orthoH1toH3(3)*h2toh1(1) - orthoH1toH3(1)*h2toh1(3)
		REFAXIS(3) = orthoH1toH3(1)*h2toh1(2) - orthoH1toH3(2)*h2toh1(1)


		s = dot_product(averagevector,REFAXIS)


		write(10,*)t, s
	 

	end do 
    close(11)
    close(10)

end subroutine timeseries


Subroutine histogram(s,counter,binwidth)
real, intent(inout) :: s
integer :: j
real, intent(inout), dimension(40) :: counter


!making a mesh with twenty slots of interval x and counting whenever the bondlength falls in that category 
 do j = 1, 40
    if ( (binwidth*(j-1) - 1.0 < s)  .and. (binwidth*(j) - 1.0 >= s)  )then
       counter(j) = counter(j) + 1
    else 
       counter(j) = counter(j)
    end if
 end do
end subroutine histogram


subroutine flipcount(s,side,m,i)
Real, intent(inout) :: s
integer, intent(inout) :: i
integer, dimension(m), intent(inout) :: side

!if its positive or zero this means the oxygen atom hasn't change its side, when s is negative then it has flipped to the other side
!representing one side by 0 and the other by 1
    if (s < 0.0)then
         side(i) = 0
        else if (s > 0.0)then
         side(i) = 1
        else
        side(i)=side(i-1)
    end if

    !write(*,*)side(i)
end subroutine flipcount


program inversion !this code gives you the number of inversions of the eigen after m steps
!This idea for quantifying the inversion is based on the fact that if the oxygen is found on one side at the first instant
!and the dot product with the axis is =+ve and at the next instance it is negative then an  inversion has occured

    implicit none

    integer :: i, j, m
    real, dimension(3) :: h1, h2, h3, o, orthoH1toH3, h2toh1
    real :: s, binwidth = 0.05, x, L = 10
    character (LEN=1) :: skipacharacter
    integer :: invcounter = 0
    real, dimension(3) :: REFAXIS, averagevector
    integer, allocatable :: side(:), inversions(:)
    real, dimension(40) :: counter
    character(LEN=100) :: argv, in_file, out_file, out_file1, out_file2!='Zundel_000.dat'


    !write(*,*)'Please input the number of steps. You can find that in the xyz file'
    !read(*,*)m
    m = 40000
    allocate(side(m))
    side = 0

	call GETARG(1,argv)	
	in_file = trim(argv)
	!print *, in_file
    
	open(unit =1,file=in_file ,status = 'old', action = 'read')

    out_file = in_file(20:23)
    call system('mkdir -p output/eiginv')
    out_file1 = 'output/eiginv/'//'Eigen-'//trim(out_file)//'dat'
	Open(unit=10, Status='replace', file=out_file1, action='write')


    !opening xyz file
    !open(unit = 1,file = 'data/Eigen/H20-pos-050.xyz',status = 'old', action = 'read')
    !Open(unit=10, Status='replace', file=out_file, action='write')
    out_file2 = 'output/eiginv/'//'Eigen_vmdcheck_'//trim(out_file)//'txt'
    Open(unit=30, Status='replace', file=out_file2, action='write')

    counter = 0.0
    do i=1, m

        read(1,*)
        read(1,*)
        read(1,*)skipacharacter,O
        read(1,*)skipacharacter,h1
        read(1,*)skipacharacter,h2
        read(1,*)skipacharacter,h3

        averagevector = (H1+H2+h3-3.0*O)/3.0
        averagevector = averagevector - nint(averagevector/L)*L
        h2toh1 = h2 - h1
        h2toh1 = h2toh1/(sqrt(dot_product(h2toh1,h2toh1)))


        !using the gram-schmidt procedure to get orthoh1toh3(a vector perpendicular to h2toh1)
        orthoH1toH3 = (h3-h1) - ((dot_product(h3-h1,h2toh1))*(h2toh1))/((h2toh1(1)**2  + h2toh1(2)**2 + h2toh1(3)**2))
        orthoH1toH3= orthoH1toH3/(sqrt(dot_product(orthoH1toH3,orthoH1toH3)))
        !finding the vector perpendicular to it using the crossproduct of orthoH1toH3 with h2toH1
        REFAXIS(1) = orthoH1toH3(2)*h2toh1(3) - orthoH1toH3(3)*h2toh1(2)
        REFAXIS(2) = orthoH1toH3(3)*h2toh1(1) - orthoH1toH3(1)*h2toh1(3)
        REFAXIS(3) = orthoH1toH3(1)*h2toh1(2) - orthoH1toH3(2)*h2toh1(1)

        REFAXIS = REFAXIS - nint(REFAXIS/L)

        s = dot_product(averagevector,REFAXIS)

        call flipcount(s,side,m,i)
        call histogram(s,counter,binwidth)
     
    end do 

    !counting the flips(moving from one side to the other(0to1 or 1to0) is a flip  
    allocate(inversions(m))
    inversions = 0
    do i = 2, m
        if ( side(i) /= side(i-1))then
            invcounter = invcounter + 1
            !write(30,*)'an inversion takes place at',i-1
            inversions(invcounter) = i-1 
        else 
          invcounter = invcounter
        end if
    end do


    counter = counter/sum(counter)
    do j = 1, 40

        !write(*,*)'(', 0.2*(j-1)- 3.0 ,',', 0.2*(j) - 3.0 ,']', 
        x = binwidth*(j*1.0) - 1.0
        write(10,*)x, counter(j)

    end do

    if (invcounter > 0) then
        write(30,*)"No of inversions:", invcounter
        write(30,*)"Location of Inversions:" 
        do i=1, invcounter
            write(30,*) inversions(i) 
        end do
    else
        write(30,*)"No. of inversions: 0" 
    end if

    write(30,*)"Total probability: ",sum(counter)

  
    deallocate(inversions, side)
    close(1)
    close(10)
    close(30)

    out_file = in_file(20:22)
    out_file1 = 'output/eiginv/'//'Eigen-'//trim(out_file)//'-tim.dat'
    call timeseries(m,in_file, out_file1)! computing timeseries



end program inversion
