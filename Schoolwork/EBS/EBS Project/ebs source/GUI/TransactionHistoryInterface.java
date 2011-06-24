package GUI;

import javax.swing.JButton;
import javax.swing.JPanel;

public class TransactionHistoryInterface extends JPanel{
	
	private BrowseInterface transactionHistoryInterface = null;	
	private static final long serialVersionUID = 1L;
	
	public TransactionHistoryInterface() {
		add(getTransactionHistoryInterface());
	}
	
	private BrowseInterface getTransactionHistoryInterface() {
		if ( transactionHistoryInterface == null )
			transactionHistoryInterface = new BrowseInterface("transactions", null, null, new JButton());
		return transactionHistoryInterface;
	}

}
