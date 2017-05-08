/* 
================================================================================
檔案代號:bmka_t
檔案名稱:ECR申請單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bmka_t
(
bmkaent       number(5)      ,/* 企業編號 */
bmkasite       varchar2(10)      ,/* 營運據點 */
bmkastus       varchar2(10)      ,/* 狀態碼 */
bmkadocno       varchar2(20)      ,/* 申請單號 */
bmkadocdt       date      ,/* 申請日期 */
bmka001       varchar2(10)      ,/* 申請模板 */
bmka002       varchar2(20)      ,/* 申請人員 */
bmka003       varchar2(10)      ,/* 申請部門 */
bmka004       date      ,/* 期望完成日期 */
bmka005       varchar2(40)      ,/* 申請變更料號 */
bmka006       varchar2(256)      ,/* 產品特徵 */
bmka007       varchar2(10)      ,/* 作業編號 */
bmka008       number(10,0)      ,/* 作業序 */
bmka009       varchar2(10)      ,/* 相關客戶廠商 */
bmka010       varchar2(20)      ,/* ECN單號 */
bmka011       varchar2(10)      ,/* 舊料件生命週期 */
bmka012       varchar2(10)      ,/* 新料件生命週期 */
bmka013       varchar2(255)      ,/* 備註 */
bmkaownid       varchar2(20)      ,/* 資料所有者 */
bmkaowndp       varchar2(10)      ,/* 資料所屬部門 */
bmkacrtid       varchar2(20)      ,/* 資料建立者 */
bmkacrtdp       varchar2(10)      ,/* 資料建立部門 */
bmkacrtdt       timestamp(0)      ,/* 資料創建日 */
bmkamodid       varchar2(20)      ,/* 資料修改者 */
bmkamoddt       timestamp(0)      ,/* 最近修改日 */
bmkacnfid       varchar2(20)      ,/* 資料確認者 */
bmkacnfdt       timestamp(0)      ,/* 資料確認日 */
bmkaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bmkaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bmkaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bmkaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bmkaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bmkaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bmkaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bmkaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bmkaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bmkaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bmkaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bmkaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bmkaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bmkaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bmkaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bmkaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bmkaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bmkaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bmkaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bmkaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bmkaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bmkaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bmkaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bmkaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bmkaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bmkaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bmkaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bmkaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bmkaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bmkaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bmka_t add constraint bmka_pk primary key (bmkaent,bmkadocno) enable validate;

create unique index bmka_pk on bmka_t (bmkaent,bmkadocno);

grant select on bmka_t to tiptop;
grant update on bmka_t to tiptop;
grant delete on bmka_t to tiptop;
grant insert on bmka_t to tiptop;

exit;
