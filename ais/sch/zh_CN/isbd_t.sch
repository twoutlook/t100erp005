/* 
================================================================================
檔案代號:isbd_t
檔案名稱:發票認證紀錄單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table isbd_t
(
isbdent       number(5)      ,/* 企業編碼 */
isbdcomp       varchar2(10)      ,/* 法人組織 */
isbddocno       varchar2(20)      ,/* 單據單號 */
isbddocdt       date      ,/* 單據日期 */
isbdsite       varchar2(10)      ,/* 賬務中心 */
isbd001       varchar2(20)      ,/* 賬務人員 */
isbdstus       varchar2(10)      ,/* 狀態碼 */
isbdownid       varchar2(20)      ,/* 資料所有者 */
isbdowndp       varchar2(10)      ,/* 資料所有部門 */
isbdcrtid       varchar2(20)      ,/* 資料建立者 */
isbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
isbdcrtdt       timestamp(0)      ,/* 資料創建日 */
isbdmodid       varchar2(20)      ,/* 資料修改者 */
isbdmoddt       timestamp(0)      ,/* 最近修改日 */
isbdcnfid       varchar2(20)      ,/* 資料確認者 */
isbdcnfdt       timestamp(0)      ,/* 資料確認日 */
isbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isbdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table isbd_t add constraint isbd_pk primary key (isbdent,isbdcomp,isbddocno) enable validate;

create unique index isbd_pk on isbd_t (isbdent,isbdcomp,isbddocno);

grant select on isbd_t to tiptop;
grant update on isbd_t to tiptop;
grant delete on isbd_t to tiptop;
grant insert on isbd_t to tiptop;

exit;
