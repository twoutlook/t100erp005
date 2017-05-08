/* 
================================================================================
檔案代號:xcdq_t
檔案名稱:每月工單人工制費成本次要素檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xcdq_t
(
xcdqent       number(5)      ,/* 企業編號 */
xcdqld       varchar2(5)      ,/* 帳別編號 */
xcdqcomp       varchar2(10)      ,/* 法人組織 */
xcdq001       varchar2(10)      ,/* 成本計算類型 */
xcdq002       number(5,0)      ,/* 年度 */
xcdq003       number(5,0)      ,/* 期別 */
xcdq004       varchar2(10)      ,/* 成本中心 */
xcdq005       varchar2(10)      ,/* 費用分類(成本次要素) */
xcdq006       varchar2(20)      ,/* 工單編號 */
xcdq007       varchar2(1)      ,/* 分攤方式 */
xcdq100       number(20,6)      ,/* 工單分攤數 */
xcdq101       number(20,6)      ,/* 單位成本(本位幣一) */
xcdq111       number(20,6)      ,/* 單位成本(本位幣二) */
xcdq121       number(20,6)      ,/* 單位成本(本位幣三) */
xcdq202       number(20,6)      ,/* 分攤金額(本位幣一) */
xcdq212       number(20,6)      ,/* 分攤金額(本位幣二) */
xcdq222       number(20,6)      ,/* 分攤金額(本位幣三) */
xcdqownid       varchar2(20)      ,/* 資料所有者 */
xcdqowndp       varchar2(10)      ,/* 資料所屬部門 */
xcdqcrtid       varchar2(20)      ,/* 資料建立者 */
xcdqcrtdp       varchar2(10)      ,/* 資料建立部門 */
xcdqcrtdt       timestamp(0)      ,/* 資料創建日 */
xcdqmodid       varchar2(20)      ,/* 資料修改者 */
xcdqmoddt       timestamp(0)      ,/* 最近修改日 */
xcdqstus       varchar2(10)      ,/* 狀態碼 */
xcdqud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xcdqud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xcdqud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xcdqud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xcdqud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xcdqud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xcdqud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xcdqud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xcdqud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xcdqud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xcdqud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xcdqud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xcdqud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xcdqud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xcdqud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xcdqud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xcdqud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xcdqud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xcdqud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xcdqud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xcdqud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xcdqud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xcdqud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xcdqud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xcdqud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xcdqud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xcdqud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xcdqud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xcdqud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xcdqud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xcdq_t add constraint xcdq_pk primary key (xcdqent,xcdqld,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,xcdq007) enable validate;

create unique index xcdq_pk on xcdq_t (xcdqent,xcdqld,xcdq001,xcdq002,xcdq003,xcdq004,xcdq005,xcdq006,xcdq007);

grant select on xcdq_t to tiptop;
grant update on xcdq_t to tiptop;
grant delete on xcdq_t to tiptop;
grant insert on xcdq_t to tiptop;

exit;
