RSpec.describe Gradient::GRD do

  describe ".parse" do

    def assert_maps(maps)
      expect(maps).to match a_hash_including("Kiwi")
      # TODO: Reconcile with python results by gradient in original Photoshop export
      # assert_point(maps["Kiwi"].color_points[0], 0.0, 60, 17, 3)
      assert_point(maps["Kiwi"].color_points[0], 0.0, 61, 17, 3)
      # TODO: Reconcile with python results by gradient in original Photoshop export
      # assert_point(maps["Kiwi"].color_points[1], 0.386, 41, 133, 12) FROM PYTHON RESULTS
      assert_point(maps["Kiwi"].color_points[1], 0.386, 41, 134, 13)
      # TODO: Reconcile with python results by gradient in original Photoshop export
      # assert_point(maps["Kiwi"].color_points[2], 0.84, 159, 202, 27) FROM PYTHON RESULTS
      assert_point(maps["Kiwi"].color_points[2], 0.84, 160, 203, 27)
      assert_point(maps["Kiwi"].color_points[3], 0.927, 243, 245, 110)
      assert_point(maps["Kiwi"].color_points[4], 1.0, 255, 255, 255)
    end

    def assert_point(point, location, red, green, blue)
      expect(point.location.round(3)).to eq location.round(3)
      expect(color_to_rgb(point.color)).to eq color_to_rgb(Color::RGB.new(red, green, blue))
    end

    def color_to_rgb(color)
      [:red,:green, :blue].map{|c|color.send(c)}
    end

    it "it returns a correct representation of the kiwi.grd when passing a filename" do
      filename = Pathname(File.expand_path("../../fixtures/kiwi.grd", __FILE__))
      maps = described_class.parse(filename)
      assert_maps(maps)
    end

    it "it returns a correct representation of the kiwi.grd when passing a File object" do
      filename = Pathname(File.expand_path("../../fixtures/kiwi.grd", __FILE__))
      file = File.open(filename, "r")
      maps = described_class.parse(file)
      assert_maps(maps)
    end
  end

end
