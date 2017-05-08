/* 
================================================================================
檔案代號:stai_t
檔案名稱:自營合約模板費用分段扣率設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stai_t
(
staient       number(5)      ,/* 企業編號 */
stai001       varchar2(10)      ,/* 模板編號 */
stai002       number(10,0)      ,/* 序號 */
stai003       number(10,0)      ,/* 序號2 */
stai004       number(20,6)      ,/* 起始金額 */
stai005       number(20,6)      ,/* 截止金額 */
stai006       number(20,6)      ,/* 扣率 */
staiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
staiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
staiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
staiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
staiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
staiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
staiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
staiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
staiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
staiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
staiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
staiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
staiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
staiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
staiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
staiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
staiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
staiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
staiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
staiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
staiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
staiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
staiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
staiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
staiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
staiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
staiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
staiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
staiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
staiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stai_t add constraint stai_pk primary key (staient,stai001,stai002,stai003) enable validate;

create unique index stai_pk on stai_t (staient,stai001,stai002,stai003);

grant select on stai_t to tiptop;
grant update on stai_t to tiptop;
grant delete on stai_t to tiptop;
grant insert on stai_t to tiptop;

exit;
