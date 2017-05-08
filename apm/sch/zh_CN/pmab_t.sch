/* 
================================================================================
檔案代號:pmab_t
檔案名稱:交易對象據點檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmab_t
(
pmabent       number(5)      ,/* 企業編號 */
pmabsite       varchar2(10)      ,/* 營運據點 */
pmab001       varchar2(10)      ,/* 交易對象編號 */
pmab002       varchar2(1)      ,/* 信用額度查核 */
pmab003       varchar2(10)      ,/* 額度交易對象 */
pmab004       varchar2(10)      ,/* 信用評核等級 */
pmab005       varchar2(10)      ,/* 額度計算幣別 */
pmab006       number(20,6)      ,/* 企業額度 */
pmab007       number(20,6)      ,/* 可超出率 */
pmab008       date      ,/* 有效期限 */
pmab009       number(5,0)      ,/* 逾期帳款寬限天數 */
pmab010       number(20,6)      ,/* 允許除外額度 */
pmab011       varchar2(10)      ,/* 額度警示水準一 */
pmab012       varchar2(10)      ,/* 水準一通知層 */
pmab013       varchar2(10)      ,/* 額度警示水準二 */
pmab014       varchar2(10)      ,/* 水準二通知層 */
pmab015       varchar2(10)      ,/* 額度警示水準三 */
pmab016       varchar2(10)      ,/* 水準三通知層 */
pmab017       varchar2(1)      ,/* 啟動預期應收通知 */
pmab018       varchar2(10)      ,/* 預期應收通知層 */
pmab030       varchar2(10)      ,/* 供應商ABC分類 */
pmab031       varchar2(20)      ,/* 負責採購人員 */
pmab032       varchar2(6)      ,/* 供應商慣用報表語言 */
pmab033       varchar2(10)      ,/* 供應商慣用交易幣別 */
pmab034       varchar2(10)      ,/* 供應商慣用交易稅別 */
pmab035       varchar2(10)      ,/* 供應商慣用發票開立方式 */
pmab036       varchar2(10)      ,/* 供應商慣用立帳方式 */
pmab037       varchar2(10)      ,/* 供應商慣用付款條件 */
pmab038       varchar2(10)      ,/* 供應商慣用採購通路 */
pmab039       varchar2(10)      ,/* 供應商慣用採購分類 */
pmab040       varchar2(10)      ,/* 供應商慣用交運方式 */
pmab041       varchar2(10)      ,/* 供應商慣用交運起點 */
pmab042       varchar2(10)      ,/* 供應商慣用交運終點 */
pmab043       varchar2(10)      ,/* 供應商慣用卸貨港 */
pmab044       varchar2(10)      ,/* 供應商慣用其他條件 */
pmab045       number(20,6)      ,/* 供應商慣用佣金率 */
pmab046       number(20,6)      ,/* 供應商折扣率 */
pmab047       varchar2(10)      ,/* 供應商慣用Forwarder */
pmab048       varchar2(80)      ,/* 供應商慣用 Notify */
pmab049       varchar2(1)      ,/* 預設允許分批收貨 */
pmab050       number(5,0)      ,/* 最多可拆解批次 */
pmab051       varchar2(1)      ,/* 預設允許提前收貨 */
pmab052       number(5,0)      ,/* 可提前收貨天數 */
pmab053       varchar2(10)      ,/* 慣用交易條件 */
pmab054       varchar2(10)      ,/* 慣用取價方式 */
pmab055       varchar2(10)      ,/* 應付帳款類別 */
pmab056       varchar2(2)      ,/* 供應商慣用發票類型 */
pmab057       varchar2(10)      ,/* 供應商慣用內外購 */
pmab058       varchar2(10)      ,/* 供應商慣用匯率計算基準 */
pmab060       varchar2(10)      ,/* 廠商評鑑計算分類 */
pmab061       number(15,3)      ,/* 價格評分 */
pmab062       number(15,3)      ,/* 達交率評分 */
pmab063       number(15,3)      ,/* 品質評分 */
pmab064       number(15,3)      ,/* 配合度評分 */
pmab065       number(15,3)      ,/* 調整加減分 */
pmab066       number(15,3)      ,/* 定性評分一 */
pmab067       number(15,3)      ,/* 定性評分二 */
pmab068       number(15,3)      ,/* 定性評分三 */
pmab069       number(15,3)      ,/* 定性評分四 */
pmab070       number(15,3)      ,/* 定性評分五 */
pmab071       varchar2(10)      ,/* 檢驗程度 */
pmab072       varchar2(10)      ,/* 檢驗水準 */
pmab073       varchar2(10)      ,/* 檢驗級數 */
pmab080       varchar2(10)      ,/* 客戶ABC分類 */
pmab081       varchar2(20)      ,/* 負責業務人員 */
pmab082       varchar2(6)      ,/* 客戶慣用報表語言 */
pmab083       varchar2(10)      ,/* 客戶慣用交易幣別 */
pmab084       varchar2(10)      ,/* 客戶慣用交易稅別 */
pmab085       varchar2(10)      ,/* 客戶慣用發票開立方式 */
pmab086       varchar2(10)      ,/* 客戶慣用立帳方式 */
pmab087       varchar2(10)      ,/* 客戶慣用收款條件 */
pmab088       varchar2(10)      ,/* 客戶慣用銷售通路 */
pmab089       varchar2(10)      ,/* 客戶慣用銷售分類 */
pmab090       varchar2(10)      ,/* 客戶慣用交運方式 */
pmab091       varchar2(10)      ,/* 客戶慣用交運起點 */
pmab092       varchar2(10)      ,/* 客戶慣用交運終點 */
pmab093       varchar2(10)      ,/* 客戶慣用卸貨港 */
pmab094       varchar2(10)      ,/* 客戶慣用其他條件 */
pmab095       number(20,6)      ,/* 客戶慣用佣金率 */
pmab096       number(20,6)      ,/* 客戶折扣率 */
pmab097       varchar2(10)      ,/* 客戶慣用Forwarder */
pmab098       varchar2(80)      ,/* 客戶慣用 Notify */
pmab099       varchar2(1)      ,/* 預設允許分批交貨 */
pmab100       number(5,0)      ,/* 最多可拆解批次 */
pmab101       varchar2(1)      ,/* 預設允許提前交貨 */
pmab102       number(5,0)      ,/* 可提前交貨天數 */
pmab103       varchar2(10)      ,/* 慣用交易條件 */
pmab104       varchar2(10)      ,/* 慣用取價方式 */
pmab105       varchar2(10)      ,/* 應收帳款類別 */
pmab106       varchar2(2)      ,/* 客戶慣用發票類型 */
pmab107       varchar2(10)      ,/* 客戶慣用內外銷 */
pmab108       varchar2(10)      ,/* 客戶慣用匯率計算基準 */
pmabownid       varchar2(20)      ,/* 資料所有者 */
pmabowndp       varchar2(10)      ,/* 資料所有部門 */
pmabcrtid       varchar2(20)      ,/* 資料建立者 */
pmabcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmabcrtdt       timestamp(0)      ,/* 資料創建日 */
pmabmodid       varchar2(20)      ,/* 資料修改者 */
pmabmoddt       timestamp(0)      ,/* 最近修改日 */
pmabcnfid       varchar2(20)      ,/* 資料確認者 */
pmabcnfdt       timestamp(0)      ,/* 資料確認日 */
pmabstus       varchar2(10)      ,/* 狀態碼 */
pmabud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmabud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmabud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmabud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmabud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmabud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmabud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmabud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmabud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmabud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmabud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmabud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmabud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmabud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmabud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmabud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmabud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmabud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmabud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmabud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmabud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmabud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmabud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmabud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmabud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmabud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmabud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmabud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmabud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmabud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmab059       varchar2(10)      ,/* 負責採購部門 */
pmab109       varchar2(10)      ,/* 負責業務部門 */
pmab110       number(20,6)      ,/* 供應商條碼包裝數量 */
pmab111       number(20,6)      ,/* 客戶條碼包裝數量 */
pmab019       number(20,6)      ,/* 逾期帳款寬限額度 */
pmab020       date      /* 除外額有效日期 */
);
alter table pmab_t add constraint pmab_pk primary key (pmabent,pmabsite,pmab001) enable validate;

create unique index pmab_pk on pmab_t (pmabent,pmabsite,pmab001);

grant select on pmab_t to tiptop;
grant update on pmab_t to tiptop;
grant delete on pmab_t to tiptop;
grant insert on pmab_t to tiptop;

exit;
