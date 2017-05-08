/* 
================================================================================
檔案代號:qcbh_t
檔案名稱:品質異常申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table qcbh_t
(
qcbhent       number(5)      ,/* 企業編號 */
qcbhsite       varchar2(10)      ,/* 營運據點 */
qcbhdocno       varchar2(20)      ,/* 品質異常申請單號 */
qcbhdocdt       date      ,/* 申請日期 */
qcbh001       varchar2(10)      ,/* 申請類型 */
qcbh002       varchar2(20)      ,/* 申請人員 */
qcbh003       varchar2(10)      ,/* 申請部門 */
qcbh004       varchar2(20)      ,/* 檢驗單號 */
qcbh005       varchar2(10)      ,/* 類型 */
qcbh006       date      ,/* 檢驗日期 */
qcbh007       varchar2(10)      ,/* 檢驗對象 */
qcbh008       varchar2(40)      ,/* 料件編號 */
qcbh009       varchar2(256)      ,/* 產品特徵 */
qcbh010       varchar2(10)      ,/* 申請原因 */
qcbh011       varchar2(20)      ,/* 參考單號 */
qcbh012       number(10,0)      ,/* 項次 */
qcbh013       number(20,6)      ,/* 申請數量 */
qcbh014       number(20,6)      ,/* 送驗數量 */
qcbh015       varchar2(10)      ,/* 單位 */
qcbh016       number(20,6)      ,/* 不良數 */
qcbh017       number(20,6)      ,/* 不良率 */
qcbh018       varchar2(1)      ,/* 責任歸屬 */
qcbh019       varchar2(10)      ,/* 廠商部門編號 */
qcbh020       varchar2(255)      ,/* 建議方式備註 */
qcbh021       number(20,6)      ,/* 本項收貨金額 */
qcbh022       number(20,6)      ,/* 本次品質異常金額 */
qcbh023       number(20,6)      ,/* 異常百分比 */
qcbh024       varchar2(255)      ,/* 備註 */
qcbh025       varchar2(10)      ,/* 作業編號 */
qcbh026       number(10,0)      ,/* 作業序 */
qcbh027       number(20,6)      ,/* 抽驗量 */
qcbh028       varchar2(10)      ,/* 交易幣別 */
qcbh029       number(20,6)      ,/* 單價 */
qcbh030       number(20,6)      ,/* 金額 */
qcbhownid       varchar2(20)      ,/* 資料所有者 */
qcbhowndp       varchar2(10)      ,/* 資料所屬部門 */
qcbhcrtid       varchar2(20)      ,/* 資料建立者 */
qcbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
qcbhcrtdt       timestamp(0)      ,/* 資料創建日 */
qcbhmodid       varchar2(20)      ,/* 資料修改者 */
qcbhmoddt       timestamp(0)      ,/* 最近修改日 */
qcbhcnfid       varchar2(20)      ,/* 資料確認者 */
qcbhcnfdt       timestamp(0)      ,/* 資料確認日 */
qcbhstus       varchar2(10)      ,/* 狀態碼 */
qcbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
qcbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
qcbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
qcbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
qcbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
qcbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
qcbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
qcbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
qcbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
qcbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
qcbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
qcbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
qcbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
qcbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
qcbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
qcbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
qcbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
qcbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
qcbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
qcbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
qcbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
qcbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
qcbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
qcbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
qcbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
qcbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
qcbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
qcbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
qcbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
qcbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table qcbh_t add constraint qcbh_pk primary key (qcbhent,qcbhdocno) enable validate;

create unique index qcbh_pk on qcbh_t (qcbhent,qcbhdocno);

grant select on qcbh_t to tiptop;
grant update on qcbh_t to tiptop;
grant delete on qcbh_t to tiptop;
grant insert on qcbh_t to tiptop;

exit;
