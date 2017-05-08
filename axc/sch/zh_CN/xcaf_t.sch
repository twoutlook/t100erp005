/* 
================================================================================
檔案代號:xcaf_t
檔案名稱:工艺资源主档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcaf_t
(
xcafent       number(5)      ,/* 企业编号 */
xcafownid       varchar2(20)      ,/* 资料所有者 */
xcafowndp       varchar2(10)      ,/* 资料所有部门 */
xcafcrtid       varchar2(20)      ,/* 资料录入者 */
xcafcrtdp       varchar2(10)      ,/* 资料录入部门 */
xcafcrtdt       timestamp(0)      ,/* 资料创建日 */
xcafmodid       varchar2(20)      ,/* 资料更改者 */
xcafmoddt       timestamp(0)      ,/* 最近更改日 */
xcafstus       varchar2(10)      ,/* 状态码 */
xcafsite       varchar2(10)      ,/* 营运据点 */
xcaf001       varchar2(10)      ,/* 版本 */
xcaf002       varchar2(40)      ,/* 工艺料号 */
xcafseq1       number(10,0)      ,/* 工艺项次 */
xcafseq2       number(10,0)      ,/* 资源项次 */
xcaf003       varchar2(20)      ,/* 资源编号 */
xcaf004       number(20,6)      ,/* 固定耗用 */
xcaf005       number(20,6)      ,/* 变动耗用 */
xcaf006       number(20,6)      ,/* 耗用批量 */
xcaf007       varchar2(80)      ,/* 备注 */
xcafud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcafud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcafud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcafud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcafud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcafud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcafud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcafud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcafud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcafud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcafud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcafud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcafud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcafud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcafud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcafud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcafud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcafud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcafud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcafud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcafud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcafud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcafud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcafud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcafud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcafud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcafud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcafud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcafud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcafud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcaf_t add constraint xcaf_pk primary key (xcafent,xcaf001,xcaf002,xcafseq1,xcafseq2) enable validate;

create unique index xcaf_pk on xcaf_t (xcafent,xcaf001,xcaf002,xcafseq1,xcafseq2);

grant select on xcaf_t to tiptop;
grant update on xcaf_t to tiptop;
grant delete on xcaf_t to tiptop;
grant insert on xcaf_t to tiptop;

exit;
