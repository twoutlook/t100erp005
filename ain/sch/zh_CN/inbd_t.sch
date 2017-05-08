/* 
================================================================================
檔案代號:inbd_t
檔案名稱:庫存留置作業單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table inbd_t
(
inbdent       number(5)      ,/* 企業編號 */
inbdsite       varchar2(10)      ,/* 營運據點 */
inbddocno       varchar2(20)      ,/* 單據編號 */
inbd001       varchar2(20)      ,/* 申請人員 */
inbd002       varchar2(10)      ,/* 申請部門 */
inbd003       varchar2(10)      ,/* 異動類型 */
inbd004       varchar2(20)      ,/* 對應留置單號 */
inbd005       varchar2(10)      ,/* 原因碼 */
inbd006       varchar2(255)      ,/* 備註 */
inbdownid       varchar2(20)      ,/* 資料所有者 */
inbdowndp       varchar2(10)      ,/* 資料所屬部門 */
inbdcrtid       varchar2(20)      ,/* 資料建立者 */
inbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
inbdcrtdt       timestamp(0)      ,/* 資料創建日 */
inbdmodid       varchar2(20)      ,/* 資料修改者 */
inbdmoddt       timestamp(0)      ,/* 最近修改日 */
inbdcnfid       varchar2(20)      ,/* 資料確認者 */
inbdcnfdt       timestamp(0)      ,/* 資料確認日 */
inbdpstid       varchar2(20)      ,/* 資料過帳者 */
inbdpstdt       timestamp(0)      ,/* 資料過帳日 */
inbdstus       varchar2(10)      ,/* 狀態碼 */
inbddocdt       date      ,/* 單據日期 */
inbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inbd_t add constraint inbd_pk primary key (inbdent,inbddocno) enable validate;

create unique index inbd_pk on inbd_t (inbdent,inbddocno);

grant select on inbd_t to tiptop;
grant update on inbd_t to tiptop;
grant delete on inbd_t to tiptop;
grant insert on inbd_t to tiptop;

exit;
