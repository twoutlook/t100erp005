/* 
================================================================================
檔案代號:gldz_t
檔案名稱:合併報表揭露事項說明檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table gldz_t
(
gldzent       number(5)      ,/* 企業編號 */
gldzld       varchar2(5)      ,/* 合併帳別 */
gldz001       varchar2(10)      ,/* 上層公司 */
gldz002       varchar2(1)      ,/* 報表類型 */
gldz003       number(5,0)      ,/* 年度 */
gldz004       number(5,0)      ,/* 期別 */
gldz005       number(10,0)      ,/* 行序 */
gldz006       varchar2(80)      ,/* 說明 */
gldz007       number(20,6)      ,/* 金額(本位幣一) */
gldz008       number(20,10)      ,/* 匯率(本位幣二) */
gldz009       number(20,6)      ,/* 金額(本位幣二) */
gldz010       number(20,10)      ,/* 匯率(本位幣三) */
gldz011       number(20,6)      ,/* 金額(本位幣三) */
gldzownid       varchar2(20)      ,/* 資料所有者 */
gldzowndp       varchar2(10)      ,/* 資料所屬部門 */
gldzcrtid       varchar2(20)      ,/* 資料建立者 */
gldzcrtdp       varchar2(10)      ,/* 資料建立部門 */
gldzcrtdt       timestamp(0)      ,/* 資料創建日 */
gldzmodid       varchar2(20)      ,/* 資料修改者 */
gldzmoddt       timestamp(0)      ,/* 最近修改日 */
gldzstus       varchar2(10)      ,/* 狀態碼 */
gldzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldz_t add constraint gldz_pk primary key (gldzent,gldzld,gldz001,gldz002,gldz003,gldz004,gldz005) enable validate;

create unique index gldz_pk on gldz_t (gldzent,gldzld,gldz001,gldz002,gldz003,gldz004,gldz005);

grant select on gldz_t to tiptop;
grant update on gldz_t to tiptop;
grant delete on gldz_t to tiptop;
grant insert on gldz_t to tiptop;

exit;
