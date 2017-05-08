/* 
================================================================================
檔案代號:rtbd_t
檔案名稱:商品轉類單資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table rtbd_t
(
rtbdent       number(5)      ,/* 企業代碼 */
rtbdsite       varchar2(10)      ,/* 營運據點 */
rtbddocno       varchar2(20)      ,/* 單據編號 */
rtbddocdt       date      ,/* 單據日期 */
rtbd001       varchar2(10)      ,/* 轉出小類 */
rtbd002       varchar2(10)      ,/* 轉入小類 */
rtbd003       varchar2(20)      ,/* 業務人員 */
rtbd004       varchar2(10)      ,/* 業務部門 */
rtbd005       varchar2(255)      ,/* 備註 */
rtbdownid       varchar2(20)      ,/* 資料所有者 */
rtbdowndp       varchar2(10)      ,/* 資料所屬部門 */
rtbdcrtid       varchar2(20)      ,/* 資料建立者 */
rtbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtbdcrtdt       timestamp(0)      ,/* 資料創建日 */
rtbdmodid       varchar2(20)      ,/* 資料修改者 */
rtbdmoddt       timestamp(0)      ,/* 最近修改日 */
rtbdcnfid       varchar2(20)      ,/* 資料確認者 */
rtbdcnfdt       timestamp(0)      ,/* 資料確認日 */
rtbdpstid       varchar2(20)      ,/* 資料過帳者 */
rtbdpstdt       timestamp(0)      ,/* 資料過帳日 */
rtbdstus       varchar2(10)      ,/* 狀態碼 */
rtbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
rtbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
rtbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
rtbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
rtbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
rtbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
rtbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
rtbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
rtbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
rtbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
rtbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
rtbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
rtbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
rtbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
rtbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
rtbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
rtbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
rtbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
rtbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
rtbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
rtbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
rtbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
rtbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
rtbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
rtbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
rtbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
rtbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
rtbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
rtbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
rtbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table rtbd_t add constraint rtbd_pk primary key (rtbdent,rtbddocno) enable validate;

create unique index rtbd_pk on rtbd_t (rtbdent,rtbddocno);

grant select on rtbd_t to tiptop;
grant update on rtbd_t to tiptop;
grant delete on rtbd_t to tiptop;
grant insert on rtbd_t to tiptop;

exit;
