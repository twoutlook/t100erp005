/* 
================================================================================
檔案代號:nmah_t
檔案名稱:票據類型設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmah_t
(
nmahent       number(5)      ,/* 企業編號 */
nmahstus       varchar2(10)      ,/* 狀態碼 */
nmah001       varchar2(10)      ,/* 票據類型編號 */
nmahownid       varchar2(20)      ,/* 資料所有者 */
nmahowndp       varchar2(10)      ,/* 資料所屬部門 */
nmahcrtid       varchar2(20)      ,/* 資料建立者 */
nmahcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmahcrtdt       timestamp(0)      ,/* 資料創建日 */
nmahmodid       varchar2(20)      ,/* 資料修改者 */
nmahmoddt       timestamp(0)      ,/* 最近修改日 */
nmahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmah_t add constraint nmah_pk primary key (nmahent,nmah001) enable validate;

create unique index nmah_pk on nmah_t (nmahent,nmah001);

grant select on nmah_t to tiptop;
grant update on nmah_t to tiptop;
grant delete on nmah_t to tiptop;
grant insert on nmah_t to tiptop;

exit;
