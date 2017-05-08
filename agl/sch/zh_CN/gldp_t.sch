/* 
================================================================================
檔案代號:gldp_t
檔案名稱:調整與銷除傳票單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table gldp_t
(
gldpent       number(5)      ,/* 企業代碼 */
gldpownid       varchar2(20)      ,/* 資料所有者 */
gldpowndp       varchar2(10)      ,/* 資料所屬部門 */
gldpcrtid       varchar2(20)      ,/* 資料建立者 */
gldpcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldpcrtdt       timestamp(0)      ,/* 資料創建日 */
gldpmodid       varchar2(20)      ,/* 資料修改者 */
gldpmoddt       timestamp(0)      ,/* 最近修改日 */
gldpcnfid       varchar2(20)      ,/* 資料確認者 */
gldpcnfdt       timestamp(0)      ,/* 資料確認日 */
gldppstid       varchar2(20)      ,/* 資料過帳者 */
gldppstdt       timestamp(0)      ,/* 資料過帳日 */
gldpstus       varchar2(10)      ,/* 狀態碼 */
gldpdocno       varchar2(20)      ,/* 傳票編號 */
gldpdocdt       date      ,/* 單據日期 */
gldpld       varchar2(5)      ,/* 合併帳套 */
gldp001       varchar2(10)      ,/* 上層公司/個體公司 */
gldp002       varchar2(5)      ,/* 帳別 */
gldp003       number(5,0)      ,/* 會計年度 */
gldp004       number(5,0)      ,/* 會計期別 */
gldp005       varchar2(1)      ,/* 來源碼 */
gldp006       varchar2(1)      ,/* 調整/沖銷類型 */
gldp007       varchar2(1)      ,/* 換匯差額調整否 */
gldp008       varchar2(10)      ,/* 幣別(記帳幣) */
gldp009       number(20,6)      ,/* 借方金額合計(記帳幣) */
gldp010       number(20,6)      ,/* 貸方金額合計(記帳幣) */
gldp011       varchar2(10)      ,/* 幣別(功能幣) */
gldp012       number(20,6)      ,/* 借方金額合計(功能幣) */
gldp013       number(20,6)      ,/* 貸方金額合計(功能幣) */
gldp014       varchar2(10)      ,/* 幣別(報告幣) */
gldp015       number(20,6)      ,/* 借方金額合計(報告幣) */
gldp016       number(20,6)      ,/* 貸方金額合計(報告幣) */
gldpud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldpud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldpud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldpud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldpud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldpud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldpud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldpud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldpud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldpud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldpud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldpud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldpud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldpud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldpud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldpud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldpud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldpud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldpud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldpud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldpud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldpud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldpud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldpud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldpud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldpud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldpud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldpud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldpud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldpud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldp_t add constraint gldp_pk primary key (gldpent,gldpdocno) enable validate;

create unique index gldp_pk on gldp_t (gldpent,gldpdocno);

grant select on gldp_t to tiptop;
grant update on gldp_t to tiptop;
grant delete on gldp_t to tiptop;
grant insert on gldp_t to tiptop;

exit;
