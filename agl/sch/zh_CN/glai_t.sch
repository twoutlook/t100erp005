/* 
================================================================================
檔案代號:glai_t
檔案名稱:自由核算項資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glai_t
(
glaistus       varchar2(10)      ,/* 狀態碼 */
glaient       number(5)      ,/* 企業編號 */
glai001       varchar2(5)      ,/* 會計科目參照表號 */
glai002       varchar2(24)      ,/* 會計科目編號 */
glai003       number(5,0)      ,/* 自由核算項1~10 */
glai004       varchar2(30)      ,/* 自由核算項值 */
glaiownid       varchar2(20)      ,/* 資料所有者 */
glaiowndp       varchar2(10)      ,/* 資料所屬部門 */
glaicrtid       varchar2(20)      ,/* 資料建立者 */
glaicrtdp       varchar2(10)      ,/* 資料建立部門 */
glaicrtdt       timestamp(0)      ,/* 資料創建日 */
glaimodid       varchar2(20)      ,/* 資料修改者 */
glaimoddt       timestamp(0)      ,/* 最近修改日 */
glaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glai_t add constraint glai_pk primary key (glaient,glai001,glai002,glai003,glai004) enable validate;

create unique index glai_pk on glai_t (glaient,glai001,glai002,glai003,glai004);

grant select on glai_t to tiptop;
grant update on glai_t to tiptop;
grant delete on glai_t to tiptop;
grant insert on glai_t to tiptop;

exit;
