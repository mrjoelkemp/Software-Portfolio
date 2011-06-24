package GUI;

import java.awt.Font;
import java.awt.GridLayout;

import javax.swing.ImageIcon;
import javax.swing.JPanel;
import javax.swing.JTabbedPane;

public class TabbedPane extends JPanel {

	private static final long serialVersionUID = 1L;

	public BrowseItemsInterface browseItemsInterface = null;

	public TabbedPane() {
		super(new GridLayout(1, 1));

		browseItemsInterface = new BrowseItemsInterface("active");

		JTabbedPane jTabbedPanel = new JTabbedPane();

		ImageIcon myAccountImage = new ImageIcon("./images/shadow.jpg");
		ImageIcon transactionHistoryImage = new ImageIcon(
				"./images/dollar_sign.gif");
		ImageIcon authorizeImage = new ImageIcon("./images/checkmark.gif");
		ImageIcon postItemImage = new ImageIcon("./images/forSaleSign.gif");
		ImageIcon browseItemImage = new ImageIcon("./images/magnify2.gif");
		ImageIcon systemStatsImage = new ImageIcon("./images/statistics.jpg");

		jTabbedPanel.setFont(new Font("Tahoma", Font.BOLD, 18));
		jTabbedPanel.addTab("Browse Items", browseItemImage,
				browseItemsInterface, "View and bid on the items up for sale");
		jTabbedPanel.addTab("My Account", myAccountImage,
				new AccountInterface(),
				"View and change your account information");
		jTabbedPanel.addTab("Post an Item", postItemImage,
				new PostItemInterface(), "Post a new item to sell");
		jTabbedPanel.addTab("My Items", browseItemImage,
				new BrowseItemsInterface("personal"),
				"View the items you have posted before");
		jTabbedPanel.addTab("Transaction History", transactionHistoryImage,
				new TransactionHistoryInterface(),
				"View your past transactions");

		if (TheMain.global_user.getInfo("SA").equalsIgnoreCase("true")) {
			jTabbedPanel.addTab("Approve Users", authorizeImage,
					new ApproveInterface("users"), "Approve users");
			jTabbedPanel.addTab("Approve Items", authorizeImage,
					new ApproveInterface("items"), "Approve items");
			jTabbedPanel.addTab("Approve Complaints", authorizeImage,
					new ApproveInterface("complaints"), "Approve complaints");
			jTabbedPanel.addTab("Statistics", systemStatsImage,
					new SystemStatsInterface(), "System Statistics");
		}

		add(jTabbedPanel);

		setOpaque(true);

	}

}
