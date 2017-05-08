/* 
================================================================================
檔案代號:pmbb_t
檔案名稱:交易對象據點申請檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table pmbb_t
(
pmbbent       number(5)      ,/* 企業編號 */
pmbbownid       varchar2(20)      ,/* 資料所有者 */
pmbbowndp       varchar2(10)      ,/* 資料所有部門 */
pmbbcrtid       varchar2(20)      ,/* 資料建立者 */
pmbbcrtdp       varchar2(10)      ,/* 資料建立部門 */
pmbbcrtdt       timestamp(0)      ,/* 資料創建日 */
pmbbmodid       varchar2(20)      ,/* 資料修改者 */
pmbbmoddt       timestamp(0)      ,/* 最近修改日 */
pmbbcnfid       varchar2(20)      ,/* 資料確認者 */
pmbbcnfdt       timestamp(0)      ,/* 資料確認日 */
pmbbstus       varchar2(10)      ,/* 狀態碼 */
pmbbdocno       varchar2(20)      ,/* 單據單號 */
pmbbsite       varchar2(10)      ,/* 營運據點 */
pmbb001       varchar2(10)      ,/* 交易對象編號 */
pmbb002       varchar2(10)      ,/* 信用額度查核 */
pmbb003       varchar2(10)      ,/* 額度交易對象 */
pmbb004       varchar2(10)      ,/* 信用評核等級 */
pmbb005       varchar2(10)      ,/* 額度計算幣別 */
pmbb006       number(20,6)      ,/* 企業額度 */
pmbb007       number(20,6)      ,/* 可超出率 */
pmbb008       date      ,/* 有效期限 */
pmbb009       number(5,0)      ,/* 逾期帳款寬限天數 */
pmbb010       number(20,6)      ,/* 允許除外額 */
pmbb011       varchar2(10)      ,/* 額度警示水準一 */
pmbb012       varchar2(10)      ,/* 水準一通知層 */
pmbb013       varchar2(10)      ,/* 額度警示水準二 */
pmbb014       varchar2(10)      ,/* 水準二通知層 */
pmbb015       varchar2(10)      ,/* 額度警示水準三 */
pmbb016       varchar2(10)      ,/* 水準三通知層 */
pmbb017       varchar2(1)      ,/* 啟動預期應收通知 */
pmbb018       varchar2(10)      ,/* 預期應收通知層 */
pmbb030       varchar2(10)      ,/* 供應商ABC分類 */
pmbb031       varchar2(20)      ,/* 負責採購人員 */
pmbb032       varchar2(6)      ,/* 供應商慣用報表語言 */
pmbb033       varchar2(10)      ,/* 供應商慣用交易幣別 */
pmbb034       varchar2(10)      ,/* 供應商慣用交易稅別 */
pmbb035       varchar2(10)      ,/* 供應商慣用發票開立方式 */
pmbb036       varchar2(10)      ,/* 供應商慣用立帳方式 */
pmbb037       varchar2(10)      ,/* 供應商慣用付款條件 */
pmbb038       varchar2(10)      ,/* 供應商慣用採購通路 */
pmbb039       varchar2(10)      ,/* 供應商慣用採購分類 */
pmbb040       varchar2(10)      ,/* 供應商慣用交運方式 */
pmbb041       varchar2(10)      ,/* 供應商慣用交運起點 */
pmbb042       varchar2(10)      ,/* 供應商慣用交運終點 */
pmbb043       varchar2(10)      ,/* 供應商慣用卸貨港 */
pmbb044       varchar2(10)      ,/* 供應商慣用其他條件 */
pmbb045       number(20,6)      ,/* 供應商慣用佣金率 */
pmbb046       number(20,6)      ,/* 供應商折扣率 */
pmbb047       varchar2(10)      ,/* 供應商慣用Forwarder */
pmbb048       varchar2(80)      ,/* 供應商慣用 Notify */
pmbb049       varchar2(1)      ,/* 預設允許分批收貨 */
pmbb050       number(5,0)      ,/* 最多可拆解批次 */
pmbb051       varchar2(1)      ,/* 預設允許提前收貨 */
pmbb052       number(5,0)      ,/* 可提前收貨天數 */
pmbb053       varchar2(10)      ,/* 慣用交易條件 */
pmbb054       varchar2(10)      ,/* 慣用取價方式 */
pmbb055       varchar2(10)      ,/* 應付帳款類別 */
pmbb056       varchar2(2)      ,/* 供應商慣用發票類型 */
pmbb057       varchar2(10)      ,/* 供應商慣用內外購 */
pmbb058       varchar2(10)      ,/* 供應商慣用匯率計算基準 */
pmbb060       varchar2(10)      ,/* 供應商評鑑計算分類 */
pmbb061       number(15,3)      ,/* 價格評分 */
pmbb062       number(15,3)      ,/* 達交率評分 */
pmbb063       number(15,3)      ,/* 品質評分 */
pmbb064       number(15,3)      ,/* 配合度評分 */
pmbb065       number(15,3)      ,/* 調整加減分 */
pmbb066       number(15,3)      ,/* 定性評分一 */
pmbb067       number(15,3)      ,/* 定性評分二 */
pmbb068       number(15,3)      ,/* 定性評分三 */
pmbb069       number(15,3)      ,/* 定性評分四 */
pmbb070       number(15,3)      ,/* 定性評分五 */
pmbb071       varchar2(10)      ,/* 檢驗程度 */
pmbb072       varchar2(10)      ,/* 檢驗水準 */
pmbb073       varchar2(10)      ,/* 檢驗級數 */
pmbb080       varchar2(10)      ,/* 客戶ABC分類 */
pmbb081       varchar2(20)      ,/* 負責業務人員 */
pmbb082       varchar2(6)      ,/* 客戶慣用報表語言 */
pmbb083       varchar2(10)      ,/* 客戶慣用交易幣別 */
pmbb084       varchar2(10)      ,/* 客戶慣用交易稅別 */
pmbb085       varchar2(10)      ,/* 客戶慣用發票開立方式 */
pmbb086       varchar2(10)      ,/* 客戶慣用立帳方式 */
pmbb087       varchar2(10)      ,/* 客戶慣用收款條件 */
pmbb088       varchar2(10)      ,/* 客戶慣用銷售通路 */
pmbb089       varchar2(10)      ,/* 客戶慣用銷售分類 */
pmbb090       varchar2(10)      ,/* 客戶慣用交運方式 */
pmbb091       varchar2(10)      ,/* 客戶慣用交運起點 */
pmbb092       varchar2(10)      ,/* 客戶慣用交運終點 */
pmbb093       varchar2(10)      ,/* 客戶慣用卸貨港 */
pmbb094       varchar2(10)      ,/* 客戶慣用其他條件 */
pmbb095       number(20,6)      ,/* 客戶慣用佣金率 */
pmbb096       number(20,6)      ,/* 客戶折扣率 */
pmbb097       varchar2(10)      ,/* 客戶慣用Forwarder */
pmbb098       varchar2(80)      ,/* 客戶慣用 Notify */
pmbb099       varchar2(1)      ,/* 預設允許分批交貨 */
pmbb100       number(5,0)      ,/* 最多可拆解批次 */
pmbb101       varchar2(1)      ,/* 預設允許提前交貨 */
pmbb102       number(5,0)      ,/* 可提前交貨天數 */
pmbb103       varchar2(10)      ,/* 慣用交易條件 */
pmbb104       varchar2(10)      ,/* 慣用取價方式 */
pmbb105       varchar2(10)      ,/* 應收帳款類別 */
pmbb106       varchar2(2)      ,/* 客戶慣用發票類型 */
pmbb107       varchar2(10)      ,/* 客戶慣用內外銷 */
pmbb108       varchar2(10)      ,/* 客戶慣用匯率計算基準 */
pmbbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmbbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmbbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmbbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmbbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmbbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmbbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmbbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmbbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmbbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmbbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmbbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmbbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmbbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmbbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmbbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmbbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmbbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmbbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmbbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmbbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmbbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmbbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmbbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmbbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmbbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmbbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmbbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmbbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmbbud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pmbb059       varchar2(10)      ,/* 負責採購部門 */
pmbb109       varchar2(10)      ,/* 負責業務部門 */
pmbb019       number(20,6)      ,/* 逾期帳款寬限額度 */
pmbb020       date      /* 除外額有效日期 */
);
alter table pmbb_t add constraint pmbb_pk primary key (pmbbent,pmbbdocno,pmbbsite) enable validate;

create unique index pmbb_pk on pmbb_t (pmbbent,pmbbdocno,pmbbsite);

grant select on pmbb_t to tiptop;
grant update on pmbb_t to tiptop;
grant delete on pmbb_t to tiptop;
grant insert on pmbb_t to tiptop;

exit;
