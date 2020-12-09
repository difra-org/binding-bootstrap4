<?php

namespace Difra\Bootstrap4;

use Difra\Controller;
use Difra\Envi\Action;
use Difra\Events\Event;

/**
 * Class Plugin
 * @package Difra\Plugins\Bootstrap4
 */
class Plugin extends \Difra\Plugin
{
    /**
     * @inheritdoc
     */
    protected function init()
    {
        \Difra\Events\System::getInstance(Event::EVENT_RENDER_INIT)->registerHandler([static::class, 'addHTML']);
    }

    public static function addHTML(Event $event)
    {
        $html = Action::getController()->html;
        $html->getHead()->addStylesheet('/bootstrap4/css/bootstrap.css');
        $html->getBody()->addScript('/bootstrap4/js/bootstrap.js');
    }
}

