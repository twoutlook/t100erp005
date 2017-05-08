/* 
================================================================================
檔案代號:pjbz_t
檔案名稱:專案人工制費收集維護檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table pjbz_t
(
pjbzent       number(5)      ,/* 企業代碼 */
pjbzcomp       varchar2(10)      ,/* 法人組織 */
pjbzld       varchar2(5)      ,/* 帳別 */
pjbz001       varchar2(10)      ,/* 費用類型 */
pjbz002       number(5,0)      ,/* 年度 */
pjbz003       number(5,0)      ,/* 期別 */
pjbz004       varchar2(20)      ,/* 專案編號 */
pjbzseq       number(10,0)      ,/* 項次 */
pjbz010       varchar2(24)      ,/* 科目編號 */
pjbz011       varchar2(10)      ,/* 營運組織 */
pjbz012       varchar2(10)      ,/* 部門 */
pjbz013       varchar2(10)      ,/* 交易對象 */
pjbz014       varchar2(10)      ,/* 客群 */
pjbz015       varchar2(10)      ,/* 區域 */
pjbz016       varchar2(10)      ,/* 成本中心 */
pjbz017       varchar2(10)      ,/* 經營類別 */
pjbz018       varchar2(10)      ,/* 渠道 */
pjbz019       varchar2(10)      ,/* 品類 */
pjbz020       varchar2(10)      ,/* 品牌 */
pjbz021       varchar2(20)      ,/* 專案編號 */
pjbz022       varchar2(30)      ,/* WBS */
pjbz100       number(20,6)      ,/* 分攤成本 */
pjbzownid       varchar2(20)      ,/* 資料所屬者 */
pjbzowndp       varchar2(10)      ,/* 資料所屬部門 */
pjbzcrtid       varchar2(20)      ,/* 資料建立者 */
pjbzcrtdp       varchar2(10)      ,/* 資料建立部門 */
pjbzcrtdt       timestamp(0)      ,/* 資料創建日 */
pjbzmodid       varchar2(20)      ,/* 資料修改者 */
pjbzmoddt       timestamp(0)      ,/* 最近修改日 */
pjbzstus       varchar2(10)      ,/* 狀態碼 */
pjbzud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pjbzud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pjbzud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pjbzud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pjbzud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pjbzud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pjbzud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pjbzud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pjbzud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pjbzud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pjbzud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pjbzud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pjbzud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pjbzud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pjbzud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pjbzud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pjbzud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pjbzud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pjbzud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pjbzud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pjbzud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pjbzud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pjbzud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pjbzud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pjbzud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pjbzud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pjbzud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pjbzud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pjbzud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pjbzud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pjbz_t add constraint pjbz_pk primary key (pjbzent,pjbzld,pjbz001,pjbz002,pjbz003,pjbz004,pjbzseq) enable validate;

create unique index pjbz_pk on pjbz_t (pjbzent,pjbzld,pjbz001,pjbz002,pjbz003,pjbz004,pjbzseq);

grant select on pjbz_t to tiptop;
grant update on pjbz_t to tiptop;
grant delete on pjbz_t to tiptop;
grant insert on pjbz_t to tiptop;

exit;
