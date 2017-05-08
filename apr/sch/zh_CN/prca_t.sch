/* 
================================================================================
檔案代號:prca_t
檔案名稱:促銷活動計劃申請資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table prca_t
(
prcaent       number(5)      ,/* 企業編號 */
prcaunit       varchar2(10)      ,/* 應用組織 */
prcasite       varchar2(10)      ,/* 營運據點 */
prcastus       varchar2(10)      ,/* 狀態碼 */
prcadocdt       date      ,/* 單據日期 */
prcadocno       varchar2(20)      ,/* 單據編號 */
prca001       varchar2(10)      ,/* 申請類型 */
prca002       varchar2(20)      ,/* 申請人員 */
prca003       varchar2(10)      ,/* 申請部門 */
prca098       varchar2(10)      ,/* 應用業態 */
prcaownid       varchar2(20)      ,/* 資料所有者 */
prcaowndp       varchar2(10)      ,/* 資料所屬部門 */
prcacrtid       varchar2(20)      ,/* 資料建立者 */
prcacrtdp       varchar2(10)      ,/* 資料建立部門 */
prcacrtdt       timestamp(0)      ,/* 資料創建日 */
prcamodid       varchar2(20)      ,/* 資料修改者 */
prcamoddt       timestamp(0)      ,/* 最近修改日 */
prcacnfid       varchar2(20)      ,/* 資料確認者 */
prcacnfdt       timestamp(0)      ,/* 資料確認日 */
prcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prca_t add constraint prca_pk primary key (prcaent,prcadocno) enable validate;

create unique index prca_pk on prca_t (prcaent,prcadocno);

grant select on prca_t to tiptop;
grant update on prca_t to tiptop;
grant delete on prca_t to tiptop;
grant insert on prca_t to tiptop;

exit;
