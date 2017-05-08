/* 
================================================================================
檔案代號:xrak_t
檔案名稱:遞延認列依帳套設定主檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xrak_t
(
xrakent       number(5)      ,/* 企業代碼 */
xrakld       varchar2(5)      ,/* 帳套 */
xrakseq       number(10,0)      ,/* 項次 */
xrak001       varchar2(10)      ,/* 遞延認列類型 */
xrak002       varchar2(10)      ,/* 銷售分群 */
xrak003       varchar2(10)      ,/* 客戶代碼 */
xrak004       varchar2(40)      ,/* 產品代碼 */
xrak005       number(5,0)      ,/* 攤銷期數 */
xrak006       varchar2(1)      ,/* 攤銷方式 */
xrak007       varchar2(24)      ,/* 遞延認列收入科目 */
xrak008       date      ,/* 有效起始日 */
xrak009       date      ,/* 有效截止日 */
xrakstus       varchar2(10)      ,/* 狀態碼 */
xrakownid       varchar2(20)      ,/* 資料所有者 */
xrakowndp       varchar2(10)      ,/* 資料所屬部門 */
xrakcrtid       varchar2(20)      ,/* 資料建立者 */
xrakcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrakcrtdt       timestamp(0)      ,/* 資料創建日 */
xrakmodid       varchar2(20)      ,/* 資料修改者 */
xrakmoddt       timestamp(0)      ,/* 最近修改日 */
xrakud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrakud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrakud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrakud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrakud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrakud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrakud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrakud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrakud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrakud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrakud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrakud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrakud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrakud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrakud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrakud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrakud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrakud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrakud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrakud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrakud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrakud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrakud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrakud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrakud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrakud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrakud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrakud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrakud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrakud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xrak_t add constraint xrak_pk primary key (xrakent,xrakld,xrakseq,xrak001) enable validate;

create unique index xrak_pk on xrak_t (xrakent,xrakld,xrakseq,xrak001);

grant select on xrak_t to tiptop;
grant update on xrak_t to tiptop;
grant delete on xrak_t to tiptop;
grant insert on xrak_t to tiptop;

exit;
