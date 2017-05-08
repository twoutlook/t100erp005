/* 
================================================================================
檔案代號:gzxk_t
檔案名稱:查询区块隐藏字段设置档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gzxk_t
(
gzxkent       number(5)      ,/* 企业编号 */
gzxkownid       varchar2(20)      ,/* 资料所有者 */
gzxkowndp       varchar2(10)      ,/* 资料所有部门 */
gzxkcrtid       varchar2(20)      ,/* 资料录入者 */
gzxkcrtdp       varchar2(10)      ,/* 资料录入部门 */
gzxkcrtdt       timestamp(0)      ,/* 资料创建日 */
gzxkmodid       varchar2(20)      ,/* 资料更改者 */
gzxkmoddt       timestamp(0)      ,/* 最近更改日 */
gzxkstus       varchar2(10)      ,/* 状态码 */
gzxk001       varchar2(20)      ,/* 画面编号 */
gzxk002       varchar2(20)      ,/* 员工编号 */
gzxk003       varchar2(1)      ,/* 客制 */
gzxk004       varchar2(40)      ,/* 字段编号 */
gzxk005       varchar2(40)      ,/* 分群位置 */
gzxk006       varchar2(1)      ,/* 类型 */
gzxkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzxkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzxkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzxkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzxkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzxkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzxkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzxkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzxkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzxkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzxkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzxkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzxkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzxkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzxkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzxkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzxkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzxkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzxkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzxkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzxkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzxkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzxkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzxkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzxkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzxkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzxkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzxkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzxkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzxkud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
gzxk007       varchar2(40)      ,/* 显示格式 */
gzxk008       varchar2(1)      /* 大小写 */
);
alter table gzxk_t add constraint gzxk_pk primary key (gzxkent,gzxk001,gzxk002,gzxk003,gzxk004) enable validate;

create unique index gzxk_pk on gzxk_t (gzxkent,gzxk001,gzxk002,gzxk003,gzxk004);

grant select on gzxk_t to tiptop;
grant update on gzxk_t to tiptop;
grant delete on gzxk_t to tiptop;
grant insert on gzxk_t to tiptop;

exit;
