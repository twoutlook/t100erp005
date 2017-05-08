/* 
================================================================================
檔案代號:imcg_t
檔案名稱:料件據點品管分群檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imcg_t
(
imcgent       number(5)      ,/* 企業編號 */
imcgownid       varchar2(20)      ,/* 資料所有者 */
imcgowndp       varchar2(10)      ,/* 資料所屬部門 */
imcgcrtid       varchar2(20)      ,/* 資料建立者 */
imcgcrtdt       timestamp(0)      ,/* 資料創建日 */
imcgcrtdp       varchar2(10)      ,/* 資料建立部門 */
imcgmodid       varchar2(20)      ,/* 資料修改者 */
imcgmoddt       timestamp(0)      ,/* 最近修改日 */
imcgstus       varchar2(10)      ,/* 狀態碼 */
imcgsite       varchar2(10)      ,/* 營運據點 */
imcg111       varchar2(10)      ,/* 品管分群 */
imcg112       varchar2(20)      ,/* 品管員 */
imcg113       varchar2(10)      ,/* 檢驗單位 */
imcg114       varchar2(1)      ,/* 進料檢驗否 */
imcg115       varchar2(10)      ,/* 檢驗程度 */
imcg116       varchar2(10)      ,/* 檢驗水準 */
imcg117       varchar2(10)      ,/* 檢驗級數 */
imcg118       number(15,3)      ,/* 庫存失效提前通知天數 */
imcg119       number(15,3)      ,/* 檢驗標準工時 */
imcg120       varchar2(1)      ,/* 使用品檢判定等級功能 */
imcgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imcgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imcgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imcgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imcgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imcgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imcgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imcgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imcgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imcgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imcgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imcgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imcgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imcgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imcgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imcgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imcgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imcgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imcgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imcgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imcgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imcgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imcgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imcgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imcgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imcgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imcgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imcgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imcgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imcgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imcg_t add constraint imcg_pk primary key (imcgent,imcgsite,imcg111) enable validate;

create unique index imcg_pk on imcg_t (imcgent,imcgsite,imcg111);

grant select on imcg_t to tiptop;
grant update on imcg_t to tiptop;
grant delete on imcg_t to tiptop;
grant insert on imcg_t to tiptop;

exit;
