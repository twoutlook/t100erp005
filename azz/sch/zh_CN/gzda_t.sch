/* 
================================================================================
檔案代號:gzda_t
檔案名稱:数据库基本设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzda_t
(
gzdastus       varchar2(10)      ,/* 状态码 */
gzda001       varchar2(20)      ,/* 数据库编号 */
gzda002       varchar2(40)      ,/* 数据库主机IP */
gzda003       varchar2(20)      ,/* 登录连接user */
gzda004       varchar2(20)      ,/* 登录连接口令 */
gzda005       varchar2(1)      ,/* 数据库类型 */
gzda006       varchar2(10)      ,/* 数据库厂牌 */
gzda007       varchar2(10)      ,/* 数据版本 */
gzda008       varchar2(80)      ,/* 数据库注记说明 */
gzdaownid       varchar2(20)      ,/* 资料所有者 */
gzdaowndp       varchar2(10)      ,/* 资料所有部门 */
gzdacrtid       varchar2(20)      ,/* 资料录入者 */
gzdacrtdp       varchar2(10)      ,/* 资料录入部门 */
gzdacrtdt       timestamp(0)      ,/* 资料创建日 */
gzdamodid       varchar2(20)      ,/* 资料更改者 */
gzdamoddt       timestamp(0)      ,/* 最近更改日 */
gzdaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzdaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzdaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzdaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzdaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzdaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzdaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzdaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzdaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzdaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzdaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzdaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzdaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzdaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzdaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzdaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzdaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzdaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzdaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzdaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzdaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzdaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzdaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzdaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzdaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzdaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzdaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzdaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzdaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzdaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzda009       varchar2(20)      ,/* TNS Service */
gzda010       varchar2(20)      /* 对应中间库编号 */
);
alter table gzda_t add constraint gzda_pk primary key (gzda001) enable validate;

create unique index gzda_pk on gzda_t (gzda001);

grant select on gzda_t to tiptop;
grant update on gzda_t to tiptop;
grant delete on gzda_t to tiptop;
grant insert on gzda_t to tiptop;

exit;
