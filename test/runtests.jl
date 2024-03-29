using MicroscopyLabels
using Test
using Documenter
using AxisArrays
using ImageMetadata

doctest(MicroscopyLabels)

@testset "timestamps" begin

    @testset "No time axis" begin
        tmp = AxisArray(rand(10, 10), Axis{:x}(1:10), Axis{:y}(1:10));

        @test_logs (:info, "No time axis detected!") timestamp!(tmp)
    end

    @testset "4+ dimensions" begin
        tmp = AxisArray(zeros(200, 200, 10, 3),
                        Axis{:x}(1:200),
                        Axis{:y}(1:200),
                        Axis{:time}(1:10),
                        Axis{:position}(1:3)
                        );
        timestamp!(tmp)

        result = """[0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0; 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.16470588235294117 0.6509803921568628 0.6705882352941176 0.16470588235294117 0.0; 0.0 0.37254901960784315 0.3333333333333333 0.0 0.0 0.0 0.0 0.0 0.0 0.2549019607843137 0.3764705882352941 0.4470588235294118 0.6705882352941176 0.0; 0.0 0.40784313725490196 1.0 0.9098039215686274 0.5803921568627451 1.0 1.0 1.0 0.09411764705882353 0.0 0.0 0.26666666666666666 0.5137254901960784 0.0; 0.0 0.40784313725490196 0.34509803921568627 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.18823529411764706 0.7019607843137254 0.03137254901960784 0.0; 0.0 0.39215686274509803 0.42745098039215684 0.058823529411764705 0.5803921568627451 1.0 1.0 1.0 0.09411764705882353 0.06666666666666667 0.6705882352941176 0.050980392156862744 0.0 0.0; 0.0 0.1607843137254902 0.9019607843137255 0.9254901960784314 0.0196078431372549 0.0 0.0 0.0 0.0 0.39215686274509803 1.0 1.0 0.9254901960784314 0.0; 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0]"""

        @test all(tmp[10:17, 10:23, 2, 1].data .≈ eval(Meta.parse(result)))
    end

    @testset "ImageMetadata" begin
        tmp = AxisArray(rand(30, 30, 10), Axis{:x}(1:30), Axis{:y}(1:30), Axis{:time}(1:10));
        timestamp!(ImageMeta(tmp))
    end

end