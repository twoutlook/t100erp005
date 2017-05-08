/* 
================================================================================
檔案代號:rtdl_t
檔案名稱:備用品牌資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table rtdl_t
(
rtdlent       number(5)      ,/* 企業編號 */
rtdl001       varchar2(10)      ,/* 品牌編號 */
rtdl002       varchar2(10)      ,/* 品類編號 */
rtdl003       varchar2(10)      ,/* 品牌屬性 */
rtdl004       varchar2(10)      ,/* 品牌價位 */
rtdl005       varchar2(10)      ,/* 經營能力 */
rtdl006       varchar2(10)      ,/* 品牌集團 */
rtdl007       varchar2(10)      ,/* 品牌性質 */
rtdl008       varchar2(10)      ,/* 品牌風格 */
rtdl009       varchar2(10)      ,/* 品牌檔次 */
rtdl010       varchar2(1)      ,/* 國際品牌 */
rtdl011       varchar2(255)      ,/* 已合作目標商場/銷售狀況 */
rtdl012       number(5,0)      ,/* 品牌年限 */
rtdl013       varchar2(255)      ,/* 適合門店 */
rtdl014       varchar2(10)      ,/* 供應商編號 */
rtdl015       varchar2(1)      ,/* 戰略合作 */
rtdl016       date      ,/* 開發日期 */
rtdl017       varchar2(20)      ,/* 開發人員 */
rtdl018       varchar2(10)      ,/* 開發部門 */
rtdl019       varchar2(10)      ,/* 開發組織 */
rtdl020       varchar2(1)      ,/* 業態 */
rtdl021       varchar2(1)      ,/* 轉正式品牌 */
rtdl022       date      ,/* 轉正式品牌日期 */
rtdl023       varchar2(20)      ,/* 轉正式品牌人員 */
rtdl024       varchar2(10)      ,/* 轉正式品牌部門 */
rtdl025       varchar2(255)      ,/* 聯絡人 */
rtdl026       varchar2(20)      ,/* 聯絡電話 */
rtdl027       varchar2(500)      ,/* 聯絡地址 */
rtdl028       varchar2(255)      ,/* 備註 */
rtdlstus       varchar2(10)      ,/* 狀態碼 */
rtdlownid       varchar2(20)      ,/* 資料所有者 */
rtdlowndp       varchar2(10)      ,/* 資料所屬部門 */
rtdlcrtid       varchar2(20)      ,/* 資料建立者 */
rtdlcrtdp       varchar2(10)      ,/* 資料建立部門 */
rtdlcrtdt       timestamp(0)      ,/* 資料創建日 */
rtdlmodid       varchar2(20)      ,/* 資料修改者 */
rtdlmoddt       timestamp(0)      /* 最近修改日 */
);
alter table rtdl_t add constraint rtdl_pk primary key (rtdlent,rtdl001) enable validate;

create unique index rtdl_pk on rtdl_t (rtdlent,rtdl001);

grant select on rtdl_t to tiptop;
grant update on rtdl_t to tiptop;
grant delete on rtdl_t to tiptop;
grant insert on rtdl_t to tiptop;

exit;
