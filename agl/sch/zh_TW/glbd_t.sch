/* 
================================================================================
檔案代號:glbd_t
檔案名稱:間接法群組資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glbd_t
(
glbdent       number(5)      ,/* 企業編號 */
glbdownid       varchar2(20)      ,/* 資料所有者 */
glbdowndp       varchar2(10)      ,/* 資料所屬部門 */
glbdcrtid       varchar2(20)      ,/* 資料建立者 */
glbdcrtdp       varchar2(10)      ,/* 資料建立部門 */
glbdcrtdt       timestamp(0)      ,/* 資料創建日 */
glbdmodid       varchar2(20)      ,/* 資料修改者 */
glbdmoddt       timestamp(0)      ,/* 最近修改日 */
glbdstus       varchar2(10)      ,/* 狀態碼 */
glbd001       varchar2(10)      ,/* 群組編號 */
glbd002       varchar2(1)      ,/* 變動分類 */
glbd003       number(10,0)      ,/* 行序 */
glbd004       varchar2(1)      ,/* 使用分類 */
glbdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbdud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
glbd005       varchar2(1)      /* 類型 */
);
alter table glbd_t add constraint glbd_pk primary key (glbdent,glbd001) enable validate;

create unique index glbd_pk on glbd_t (glbdent,glbd001);

grant select on glbd_t to tiptop;
grant update on glbd_t to tiptop;
grant delete on glbd_t to tiptop;
grant insert on glbd_t to tiptop;

exit;
