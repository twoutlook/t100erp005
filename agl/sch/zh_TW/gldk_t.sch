/* 
================================================================================
檔案代號:gldk_t
檔案名稱:合併報表會計科目沖銷規則_MULTI來源科目資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldk_t
(
gldkent       number(5)      ,/* 企業代碼 */
gldk001       varchar2(10)      ,/* 公司編號(來源) */
gldk002       varchar2(5)      ,/* 合併帳別(來源) */
gldk003       varchar2(10)      ,/* 公司編號(對沖) */
gldk004       varchar2(5)      ,/* 合併帳別(對沖) */
gldk005       varchar2(24)      ,/* 上層公司(合併主體) */
gldk006       varchar2(24)      ,/* 合併帳別(合併主體) */
gldk007       varchar2(10)      ,/* 沖銷組別序號 */
gldk008       varchar2(24)      ,/* MULTI代號設定值(來源公司) */
gldk009       varchar2(24)      ,/* 科目編號 */
gldkownid       varchar2(20)      ,/* 資料所有者 */
gldkowndp       varchar2(10)      ,/* 資料所屬部門 */
gldkcrtid       varchar2(20)      ,/* 資料建立者 */
gldkcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldkcrtdt       timestamp(0)      ,/* 資料創建日 */
gldkmodid       varchar2(20)      ,/* 資料修改者 */
gldkmoddt       timestamp(0)      ,/* 最近修改日 */
gldkstus       varchar2(10)      ,/* 狀態碼 */
gldkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldk_t add constraint gldk_pk primary key (gldkent,gldk001,gldk002,gldk003,gldk004,gldk005,gldk006,gldk007,gldk008,gldk009) enable validate;

create unique index gldk_pk on gldk_t (gldkent,gldk001,gldk002,gldk003,gldk004,gldk005,gldk006,gldk007,gldk008,gldk009);

grant select on gldk_t to tiptop;
grant update on gldk_t to tiptop;
grant delete on gldk_t to tiptop;
grant insert on gldk_t to tiptop;

exit;
