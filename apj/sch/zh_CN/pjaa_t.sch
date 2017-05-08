/* 
================================================================================
檔案代號:pjaa_t
檔案名稱:專案類型檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjaa_t
(
pjaaent       number(5)      ,/* 企業編號 */
pjaa001       varchar2(10)      ,/* 專案類型 */
pjaa002       varchar2(20)      ,/* 參照範本 */
pjaa003       varchar2(1)      ,/* 專案與訂單連動 */
pjaa004       varchar2(1)      ,/* 專案編號與訂單單號一致 */
pjaa005       varchar2(1)      ,/* 專案做預算控管 */
pjaa006       varchar2(10)      ,/* 專案結構 */
pjaa007       varchar2(10)      ,/* 專案編號編碼分類 */
pjaa008       varchar2(10)      ,/* WBS編碼原則 */
pjaa009       number(5,0)      ,/* WBS編碼各段碼長 */
pjaa010       varchar2(1)      ,/* 使用活動網路圖 */
pjaa011       varchar2(10)      ,/* 網路編碼原則 */
pjaa012       varchar2(10)      ,/* 活動編碼原則 */
pjaaownid       varchar2(20)      ,/* 資料所有者 */
pjaaowndp       varchar2(10)      ,/* 資料所屬部門 */
pjaacrtid       varchar2(20)      ,/* 資料建立者 */
pjaacrtdp       varchar2(10)      ,/* 資料建立部門 */
pjaacrtdt       timestamp(0)      ,/* 資料創建日 */
pjaamodid       varchar2(20)      ,/* 資料修改者 */
pjaamoddt       timestamp(0)      ,/* 最近修改日 */
pjaastus       varchar2(10)      ,/* 狀態碼 */
pjaaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjaaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjaaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjaaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjaaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjaaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjaaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjaaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjaaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjaaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjaaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjaaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjaaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjaaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjaaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjaaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjaaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjaaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjaaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjaaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjaaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjaaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjaaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjaaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjaaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjaaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjaaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjaaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjaaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjaaud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
pjaa013       varchar2(1)      ,/* 專案庫存控管 */
pjaa014       varchar2(10)      /* 結案階段 */
);
alter table pjaa_t add constraint pjaa_pk primary key (pjaaent,pjaa001) enable validate;

create unique index pjaa_pk on pjaa_t (pjaaent,pjaa001);

grant select on pjaa_t to tiptop;
grant update on pjaa_t to tiptop;
grant delete on pjaa_t to tiptop;
grant insert on pjaa_t to tiptop;

exit;
