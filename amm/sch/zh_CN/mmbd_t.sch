/* 
================================================================================
檔案代號:mmbd_t
檔案名稱:會員卡狀態異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table mmbd_t
(
mmbdent       number(5)      ,/* 企業編號 */
mmbdsite       varchar2(10)      ,/* 營運據點 */
mmbddocno       varchar2(20)      ,/* 單據編號 */
mmbddocdt       date      ,/* 單據日期 */
mmbd000       varchar2(10)      ,/* 異動類別 */
mmbd001       varchar2(10)      ,/* 異動來源 */
mmbd002       varchar2(10)      ,/* 理由碼 */
mmbdstus       varchar2(10)      ,/* 狀態碼 */
mmbdownid       varchar2(20)      ,/* 資料所有者 */
mmbdowndp       varchar2(10)      ,/* 資料所屬部門 */
mmbdcrtid       varchar2(20)      ,/* 資料建立者 */
mmbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
mmbdcrtdt       timestamp(0)      ,/* 資料創建日 */
mmbdmodid       varchar2(20)      ,/* 資料修改者 */
mmbdmoddt       timestamp(0)      ,/* 最近修改日 */
mmbdcnfid       varchar2(20)      ,/* 資料確認者 */
mmbdcnfdt       timestamp(0)      ,/* 資料確認日 */
mmbdunit       varchar2(10)      ,/* 應用組織 */
mmbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mmbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mmbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mmbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mmbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mmbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mmbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mmbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mmbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mmbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mmbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mmbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mmbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mmbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mmbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mmbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mmbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mmbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mmbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mmbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mmbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mmbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mmbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mmbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mmbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mmbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mmbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mmbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mmbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mmbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mmbd_t add constraint mmbd_pk primary key (mmbdent,mmbddocno) enable validate;

create unique index mmbd_pk on mmbd_t (mmbdent,mmbddocno);

grant select on mmbd_t to tiptop;
grant update on mmbd_t to tiptop;
grant delete on mmbd_t to tiptop;
grant insert on mmbd_t to tiptop;

exit;
